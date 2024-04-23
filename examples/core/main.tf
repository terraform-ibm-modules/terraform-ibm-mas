########################################################################################################################
# MAS Core on an existing Openshift cluster
########################################################################################################################

locals {
  zone                      = "${var.region}-2"
  maximo_admin_url          = module.mas_core.maximo_admin_url
  pipeline_execution_status = module.mas_core.pipeline_execution_status
}
##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.4"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Create a test VPC
##############################################################################

resource "ibm_is_vpc" "example_vpc" {
  name           = "${var.prefix}-vpc"
  resource_group = module.resource_group.resource_group_id
  tags           = var.resource_tags

}

resource "ibm_is_public_gateway" "testacc_gateway" {
  name           = "${var.prefix}-pgway"
  vpc            = ibm_is_vpc.example_vpc.id
  zone           = local.zone
  resource_group = module.resource_group.resource_group_id
}

resource "ibm_is_subnet" "testacc_subnet" {
  name                     = "${var.prefix}-subnet"
  vpc                      = ibm_is_vpc.example_vpc.id
  zone                     = local.zone
  public_gateway           = ibm_is_public_gateway.testacc_gateway.id
  total_ipv4_address_count = 256
  resource_group           = module.resource_group.resource_group_id
}

##############################################################################
# Create a test OCP Cluster
##############################################################################

resource "ibm_resource_instance" "cos_instance" {
  name              = "${var.prefix}-cos"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.resource_tags
}

# Lookup the current default kube version
data "ibm_container_cluster_versions" "cluster_versions" {}
locals {
  default_ocp_version = "${data.ibm_container_cluster_versions.cluster_versions.default_openshift_version}_openshift"
}

resource "ibm_container_vpc_cluster" "cluster" {
  name             = "${var.prefix}-ocp"
  vpc_id           = ibm_is_vpc.example_vpc.id
  kube_version     = local.default_ocp_version
  flavor           = "bx2.16x64"
  worker_count     = "3"
  entitlement      = "cloud_pak"
  cos_instance_crn = ibm_resource_instance.cos_instance.id
  zones {
    subnet_id = ibm_is_subnet.testacc_subnet.id
    name      = local.zone
  }
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.resource_tags
}

##############################################################################
# Init cluster config for helm and kubernetes providers
##############################################################################

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id   = ibm_container_vpc_cluster.cluster.id
  resource_group_id = module.resource_group.resource_group_id
}

# Sleep to allow RBAC sync on cluster
resource "time_sleep" "wait_operators" {
  depends_on      = [data.ibm_container_cluster_config.cluster_config]
  create_duration = "5s"
}

##############################################################################
# Deploy MAS Core
##############################################################################

module "mas_core" {
  source                = "../.."
  cluster_id            = ibm_container_vpc_cluster.cluster.id
  region                = var.region
  mas_entitlement_key   = var.mas_entitlement_key
  ibmcloud_api_key      = var.ibmcloud_api_key
  mas_license           = var.mas_license
  sls_license_id        = var.sls_license_id
  deployment_flavour    = "core"
  mas_instance_id       = "inst"
  uds_contact_email     = "test@ibm.com"
  uds_contact_firstname = "test"
  uds_contact_lastname  = "test"
}
