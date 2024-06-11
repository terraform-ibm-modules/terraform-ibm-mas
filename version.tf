terraform {
  required_version = ">= 1.3.0"
  required_providers {
    # Use a range in modules
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">= 1.59.0, < 2.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.0.0, <2.5.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.8.0, <3.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1, < 4.0.0"
    }
  }
}
