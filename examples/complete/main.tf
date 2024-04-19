##############################################################################
# Complete example
##############################################################################

module "landing_zone" {
  source                 = "git::https://github.com/terraform-ibm-modules/terraform-ibm-landing-zone//patterns//roks//module?ref=v5.1.1-rc"
  region                 = var.region
  prefix                 = var.prefix
  tags                   = var.resource_tags
  enable_transit_gateway = false
  add_atracker_route     = false

  override_json_string = <<EOF
{
  "access_groups": [],
  "add_kms_block_storage_s2s": true,
  "appid": {
    "keys": [
      "slz-appid-key"
    ],
    "name": "appid",
    "resource_group": "masda-service-rg",
    "use_appid": false,
    "use_data": false
  },
  "atracker": {
    "add_route": true,
    "collector_bucket_name": "atracker-bucket",
    "receive_global_events": true,
    "resource_group": "masda-service-rg"
  },
  "clusters": [
    {
      "boot_volume_crk_name": "masda-roks-key",
      "cos_name": "cos",
      "entitlement": "cloud_pak",
      "kms_config": {
        "crk_name": "masda-roks-key",
        "private_endpoint": true
      },
      "kube_type": "openshift",
      "kube_version": "4.12_openshift",
      "machine_type": "bx2.16x64",
      "name": "management-cluster",
      "resource_group": "masda-management-rg",
      "subnet_names": [
        "vsi-zone-1",
        "vsi-zone-2",
        "vsi-zone-3"
      ],
      "update_all_workers": false,
      "vpc_name": "management",
      "worker_pools": [],
      "workers_per_subnet": 1
    },
    {
      "boot_volume_crk_name": "masda-roks-key",
      "cos_name": "cos",
      "entitlement": "cloud_pak",
      "kms_config": {
        "crk_name": "masda-roks-key",
        "private_endpoint": true
      },
      "kube_type": "openshift",
      "kube_version": "4.12_openshift",
      "machine_type": "bx2.16x64",
      "name": "workload-cluster",
      "resource_group": "masda-workload-rg",
      "subnet_names": [
        "vsi-zone-1",
        "vsi-zone-2",
        "vsi-zone-3"
      ],
      "update_all_workers": false,
      "vpc_name": "workload",
      "workers_per_subnet": 1,
      "worker_pools": [
        {
          "subnet_names": [
            "vsi-zone-1",
            "vsi-zone-2",
            "vsi-zone-3"
          ],
          "vpc_name": "workload",
          "flavor": "bx2.16x64",
          "name": "ocs",
          "workers_per_subnet": 1,
          "entitlement": "cloud_pak"
        }
      ]
    }
  ],
  "cos": [
    {
      "access_tags": [],
      "buckets": [
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "masda-atracker-key",
          "name": "atracker-bucket",
          "storage_class": "standard"
        }
      ],
      "keys": [],
      "name": "atracker-cos",
      "plan": "standard",
      "random_suffix": true,
      "resource_group": "masda-service-rg",
      "use_data": false
    },
    {
      "access_tags": [],
      "buckets": [
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "masda-slz-key",
          "name": "management-bucket",
          "storage_class": "standard"
        },
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "masda-slz-key",
          "name": "workload-bucket",
          "storage_class": "standard"
        }
      ],
      "keys": [],
      "name": "cos",
      "plan": "standard",
      "random_suffix": true,
      "resource_group": "masda-service-rg",
      "use_data": false
    }
  ],
  "enable_transit_gateway": true,
  "f5_template_data": {
    "app_id": "null",
    "as3_declaration_url": "null",
    "byol_license_basekey": null,
    "do_declaration_url": "null",
    "license_host": null,
    "license_password": null,
    "license_pool": null,
    "license_sku_keyword_1": null,
    "license_sku_keyword_2": null,
    "license_type": "none",
    "license_unit_of_measure": "hourly",
    "license_username": null,
    "phone_home_url": "null",
    "template_source": "f5devcentral/ibmcloud_schematics_bigip_multinic_declared",
    "template_version": "20210201",
    "tgactive_url": "",
    "tgrefresh_url": "null",
    "tgstandby_url": "null",
    "tmos_admin_password": null,
    "ts_declaration_url": "null"
  },
  "f5_vsi": [],
  "iam_account_settings": {
    "enable": false
  },
  "key_management": {
    "access_tags": [],
    "keys": [
      {
        "key_ring": "masda-slz-ring",
        "name": "masda-slz-key",
        "policies": {
          "rotation": {
            "interval_month": 12
          }
        },
        "root_key": true
      },
      {
        "key_ring": "masda-slz-ring",
        "name": "masda-atracker-key",
        "policies": {
          "rotation": {
            "interval_month": 12
          }
        },
        "root_key": true
      },
      {
        "key_ring": "masda-slz-ring",
        "name": "masda-roks-key",
        "policies": {
          "rotation": {
            "interval_month": 12
          }
        },
        "root_key": true
      }
    ],
    "name": "masda-slz-kms",
    "resource_group": "masda-service-rg",
    "use_hs_crypto": false,
    "use_data": false
  },
  "network_cidr": "10.0.0.0/8",
  "resource_groups": [
    {
      "create": true,
      "name": "masda-service-rg",
      "use_prefix": false
    },
    {
      "create": true,
      "name": "masda-management-rg",
      "use_prefix": false
    },
    {
      "create": true,
      "name": "masda-workload-rg",
      "use_prefix": false
    }
  ],
  "secrets_manager": {
    "kms_key_name": null,
    "name": null,
    "resource_group": null,
    "use_secrets_manager": false
  },
  "security_compliance_center": {
    "collector_description": null,
    "collector_passphrase": null,
    "enable_scc": false,
    "is_public": false,
    "location_id": "us",
    "scope_description": null,
    "scope_name": "scope"
  },
  "security_groups": [
    {
      "name": "management-vpe-sg",
      "resource_group": "masda-management-rg",
      "rules": [
        {
          "direction": "inbound",
          "name": "allow-ibm-inbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": null,
            "port_min": null
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "inbound",
          "name": "allow-vpc-inbound",
          "source": "10.0.0.0/8",
          "tcp": {
            "port_max": null,
            "port_min": null
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-vpc-outbound",
          "source": "10.0.0.0/8",
          "tcp": {
            "port_max": null,
            "port_min": null
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-ibm-tcp-53-outbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": 53,
            "port_min": 53
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-ibm-tcp-80-outbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": 80,
            "port_min": 80
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-ibm-tcp-443-outbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": 443,
            "port_min": 443
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        }
      ],
      "vpc_name": "management"
    },
    {
      "name": "workload-vpe-sg",
      "resource_group": "masda-workload-rg",
      "rules": [
        {
          "direction": "inbound",
          "name": "allow-ibm-inbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": null,
            "port_min": null
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "inbound",
          "name": "allow-vpc-inbound",
          "source": "10.0.0.0/8",
          "tcp": {
            "port_max": null,
            "port_min": null
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-vpc-outbound",
          "source": "10.0.0.0/8",
          "tcp": {
            "port_max": null,
            "port_min": null
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-ibm-tcp-53-outbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": 53,
            "port_min": 53
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-ibm-tcp-80-outbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": 80,
            "port_min": 80
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        },
        {
          "direction": "outbound",
          "name": "allow-ibm-tcp-443-outbound",
          "source": "161.26.0.0/16",
          "tcp": {
            "port_max": 443,
            "port_min": 443
          },
          "icmp": {
            "type": null,
            "code": null
          },
          "udp": {
            "port_min": null,
            "port_max": null
          }
        }
      ],
      "vpc_name": "workload"
    }
  ],
  "service_endpoints": "public-and-private",
  "ssh_keys": [],
  "teleport_config": {
    "app_id_key_name": null,
    "claims_to_roles": [
      {
        "email": null,
        "roles": [
          "teleport-admin"
        ]
      }
    ],
    "cos_bucket_name": "bastion-bucket",
    "cos_key_name": "bastion-key",
    "domain": null,
    "hostname": null,
    "https_cert": null,
    "https_key": null,
    "message_of_the_day": null,
    "teleport_license": null,
    "teleport_version": "7.1.0"
  },
  "teleport_vsi": [],
  "transit_gateway_connections": [
    "management",
    "workload"
  ],
  "transit_gateway_global": false,
  "transit_gateway_resource_group": "masda-service-rg",
  "virtual_private_endpoints": [
    {
      "resource_group": "masda-service-rg",
      "service_name": "cos",
      "service_type": "cloud-object-storage",
      "vpcs": [
        {
          "name": "management",
          "security_group_name": "management-vpe-sg",
          "subnets": [
            "vpe-zone-1",
            "vpe-zone-2",
            "vpe-zone-3"
          ]
        },
        {
          "name": "workload",
          "security_group_name": "workload-vpe-sg",
          "subnets": [
            "vpe-zone-1",
            "vpe-zone-2",
            "vpe-zone-3"
          ]
        }
      ]
    }
  ],
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
      "flow_logs_bucket_name": "management-bucket",
      "network_acls": [
        {
          "add_ibm_cloud_internal_rules": true,
          "add_vpc_connectivity_rules": true,
          "name": "management-acl",
          "prepend_ibm_rules": true,
          "rules": [
            {
              "name": "all-all-dev",
              "action": "allow",
              "direction": "inbound",
              "icmp": {
                "type": null,
                "code": null
              },
              "tcp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "udp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "source": "0.0.0.0/0",
              "destination": "0.0.0.0/0"
            },
            {
              "name": "all-all-dev-outbound",
              "action": "allow",
              "direction": "outbound",
              "icmp": {
                "type": null,
                "code": null
              },
              "tcp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "udp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "source": "0.0.0.0/0",
              "destination": "0.0.0.0/0"
            }
          ]
        }
      ],
      "prefix": "management",
      "resource_group": "masda-management-rg",
      "subnets": {
        "zone-1": [
          {
            "acl_name": "management-acl",
            "cidr": "10.10.20.0/24",
            "name": "vpe-zone-1",
            "public_gateway": false
          },
          {
            "acl_name": "management-acl",
            "cidr": "10.10.30.0/24",
            "name": "vpn-zone-1",
            "public_gateway": false
          },
          {
            "acl_name": "management-acl",
            "cidr": "10.10.10.0/24",
            "name": "vsi-zone-1",
            "public_gateway": true
          }
        ],
        "zone-2": [
          {
            "acl_name": "management-acl",
            "cidr": "10.20.20.0/24",
            "name": "vpe-zone-2",
            "public_gateway": false
          },
          {
            "acl_name": "management-acl",
            "cidr": "10.20.10.0/24",
            "name": "vsi-zone-2",
            "public_gateway": true
          }
        ],
        "zone-3": [
          {
            "acl_name": "management-acl",
            "cidr": "10.30.20.0/24",
            "name": "vpe-zone-3",
            "public_gateway": false
          },
          {
            "acl_name": "management-acl",
            "cidr": "10.30.10.0/24",
            "name": "vsi-zone-3",
            "public_gateway": true
          }
        ]
      },
      "use_public_gateways": {
        "zone-1": true,
        "zone-2": true,
        "zone-3": true
      },
      "default_network_acl_name": null,
      "default_routing_table_name": null,
      "default_security_group_name": null,
      "classic_access": false,
      "use_manual_address_prefixes": false
    },
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
              "name": "allow-all-dev",
              "action": "allow",
              "direction": "inbound",
              "icmp": {
                "type": null,
                "code": null
              },
              "tcp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "udp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "source": "0.0.0.0/0",
              "destination": "0.0.0.0/0"
            },
            {
              "name": "allow-all-dev-outbound",
              "action": "allow",
              "direction": "outbound",
              "icmp": {
                "type": null,
                "code": null
              },
              "tcp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "udp": {
                "port_min": null,
                "port_max": null,
                "source_port_min": null,
                "source_port_max": null
              },
              "source": "0.0.0.0/0",
              "destination": "0.0.0.0/0"
            }
          ]
        }
      ],
      "prefix": "workload",
      "resource_group": "masda-workload-rg",
      "subnets": {
        "zone-1": [
          {
            "acl_name": "workload-acl",
            "cidr": "10.40.20.0/24",
            "name": "vpe-zone-1",
            "public_gateway": false
          },
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
            "cidr": "10.50.20.0/24",
            "name": "vpe-zone-2",
            "public_gateway": false
          },
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
            "cidr": "10.60.20.0/24",
            "name": "vpe-zone-3",
            "public_gateway": false
          },
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
      },
      "default_network_acl_name": null,
      "default_routing_table_name": null,
      "default_security_group_name": null,
      "classic_access": false,
      "use_manual_address_prefixes": false
    }
  ],
  "vpn_gateways": [
    {
      "connections": [],
      "name": "management-gateway",
      "resource_group": "masda-management-rg",
      "subnet_name": "vpn-zone-1",
      "vpc_name": "management"
    }
  ],
  "vsi": [],
  "wait_till": "IngressReady"
}
EOF
}