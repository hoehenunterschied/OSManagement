terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.0.0"
    }
  }
  backend "s3" {
    bucket   = "TerraformStates"
    key      = "OSManagement/terraform.tfstate"
    region   = "eu-frankfurt-1"
    endpoint = "https://fr9qm01oq44x.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    shared_credentials_file     = "~/.oci/terraform-states_bucket_credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
provider "oci" {
  region              = var.target_region
  tenancy_ocid        = var.tenancy_ocid
  user_ocid           = var.user_ocid
  fingerprint         = var.fingerprint
  private_key_path    = var.private_key_path
  ignore_defined_tags = var.ignore_defined_tags
}
provider "oci" {
  alias               = "home"
  region              = lookup(local.region_map, data.oci_identity_tenancy.tenancy.home_region_key)
  tenancy_ocid        = var.tenancy_ocid
  user_ocid           = var.user_ocid
  fingerprint         = var.fingerprint
  private_key_path    = var.private_key_path
  ignore_defined_tags = var.ignore_defined_tags
}

data oci_identity_regions regions {}

data oci_identity_tenancy tenancy {
  tenancy_id = var.tenancy_ocid
}

locals {
  region_map = { for r in data.oci_identity_regions.regions.regions : r.key => r.name }
}

output home_region {
  value = lookup(local.region_map, data.oci_identity_tenancy.tenancy.home_region_key)
}
output target_region {
  value = var.target_region
}
