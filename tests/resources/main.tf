##############################################################################
# SLZ OCP
##############################################################################

data "ibm_container_cluster_versions" "cluster_versions" {
}

locals {
  default_ocp_version = "${data.ibm_container_cluster_versions.cluster_versions.default_openshift_version}_openshift"
  ocp_version         = var.ocp_version == null || var.ocp_version == "default" ? local.default_ocp_version : "${var.ocp_version}_openshift"
}

module "landing_zone" {
  source  = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version = "5.21.0"
  region  = var.region
  prefix  = var.prefix
  tags    = var.resource_tags

  # Create 1 public cluster using override json
  # TODO: Replace this with actual override.json that DA docs will point to
  override_json_string = <<EOF
{
  "atracker": {
    "add_route": true,
    "collector_bucket_name": "atracker-bucket",
    "receive_global_events": true,
    "resource_group": "service-rg"
  },
  "clusters": [
    {
      "addons": { "vpc-file-csi-driver": "1.2" },
      "boot_volume_crk_name": "roks-key",
      "cos_name": "cos",
      "entitlement": null,
      "kms_config": {
        "crk_name": "roks-key",
        "private_endpoint": true
      },
      "kube_type": "openshift",
      "kube_version": "${local.ocp_version}",
      "machine_type": "bx2.16x64",
      "manage_all_addons": false,
      "name": "workload-cluster",
      "resource_group": "workload-rg",
      "secondary_storage": null,
      "subnet_names": [
        "vsi-zone-1",
        "vsi-zone-2",
        "vsi-zone-3"
      ],
      "vpc_name": "workload",
      "worker_pools": [],
      "workers_per_subnet": 1,
      "disable_public_endpoint": false
    }
  ],
  "cos": [
    {
      "access_tags": [],
      "buckets": [
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "atracker-key",
          "name": "atracker-bucket",
          "storage_class": "standard"
        }
      ],
      "keys": [],
      "name": "atracker-cos",
      "plan": "standard",
      "random_suffix": true,
      "resource_group": "service-rg",
      "use_data": false
    },
    {
      "access_tags": [],
      "buckets": [
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "slz-key",
          "name": "workload-bucket",
          "storage_class": "standard"
        }
      ],
      "keys": [],
      "name": "cos",
      "plan": "standard",
      "random_suffix": true,
      "resource_group": "service-rg",
      "use_data": false
    }
  ],
  "enable_transit_gateway": false,
  "key_management": {
    "access_tags": [],
    "keys": [
      {
        "key_ring": "slz-ring",
        "name": "slz-key",
        "policies": {
          "rotation": {
            "interval_month": 12
          }
        },
        "root_key": true
      },
      {
        "key_ring": "slz-ring",
        "name": "atracker-key",
        "policies": {
          "rotation": {
            "interval_month": 12
          }
        },
        "root_key": true
      },
      {
        "key_ring": "slz-ring",
        "name": "roks-key",
        "policies": {
          "rotation": {
            "interval_month": 12
          }
        },
        "root_key": true
      }
    ],
    "name": "slz-kms",
    "resource_group": "service-rg",
    "use_hs_crypto": false
  },
  "network_cidr": "10.0.0.0/8",
  "resource_groups": [
    {
      "create": true,
      "name": "service-rg"
    },
    {
      "create": true,
      "name": "workload-rg"
    }
  ],
  "security_groups": [],
  "service_endpoints": "public-and-private",
  "skip_all_s2s_auth_policies": false,
  "skip_kms_block_storage_s2s_auth_policy": false,
  "ssh_keys": [],
  "transit_gateway_connections": [],
  "transit_gateway_global": false,
  "transit_gateway_resource_group": "service-rg",
  "virtual_private_endpoints": [],
  "vpc_placement_groups": [],
  "vpcs": [
    {
      "access_tags": [],
      "address_prefixes": {
        "zone-1": [],
        "zone-2": [],
        "zone-3": []
      },
      "clean_default_sg_acl": false,
      "default_security_group_rules": [],
      "flow_logs_bucket_name": "workload-bucket",
      "network_acls": [
        {
          "add_ibm_cloud_internal_rules": true,
          "add_vpc_connectivity_rules": true,
          "name": "workload-acl",
          "prepend_ibm_rules": true,
          "rules": [
            {
              "name": "allow-https-inbound",
              "action": "allow",
              "direction": "inbound",
              "tcp": {
                "port_min": 80,
                "port_max": 65535
              },
              "source": "0.0.0.0/0",
              "destination": "0.0.0.0/0"
            },
            {
              "name": "allow-https-outbound",
              "action": "allow",
              "direction": "outbound",
              "tcp": {
                "source_port_min": 80,
                "source_port_max": 65535
              },
              "destination": "0.0.0.0/0",
              "source": "0.0.0.0/0"
            }
          ]
        }
      ],
      "prefix": "workload",
      "resource_group": "workload-rg",
      "subnets": {
        "zone-1": [
          {
            "acl_name": "workload-acl",
            "cidr": "10.40.10.0/24",
            "name": "vsi-zone-1",
            "public_gateway": true
          }
        ],
        "zone-2": [
          {
            "acl_name": "workload-acl",
            "cidr": "10.50.10.0/24",
            "name": "vsi-zone-2",
            "public_gateway": true
          }
        ],
        "zone-3": [
          {
            "acl_name": "workload-acl",
            "cidr": "10.60.10.0/24",
            "name": "vsi-zone-3",
            "public_gateway": true
          }
        ]
      },
      "use_public_gateways": {
        "zone-1": true,
        "zone-2": true,
        "zone-3": true
      }
    }
  ],
  "vpn_gateways": [],
  "vsi": [],
  "wait_till": "IngressReady"
}
EOF
}
