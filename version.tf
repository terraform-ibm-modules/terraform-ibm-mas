terraform {
  required_version = ">= 1.3.0, <1.7.0"
  required_providers {
    # Use a range in modules
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">= 1.59.0, < 2.0.0"
    }
	time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1, < 1.0.0"
    }
	external = {
      source  = "hashicorp/external"
      version = ">=2.2.3, <3.0.0"
    }	
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.8.0, <3.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1, <3.0.0"
    }    
  }
}
