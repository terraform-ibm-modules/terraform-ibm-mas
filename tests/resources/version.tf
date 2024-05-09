terraform {
  required_version = ">= 1.3.0, <1.7.0"
  required_providers {
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">= 1.59.0, < 2.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1, < 4.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.11.1, <1.0.0"
    }
  }
}
