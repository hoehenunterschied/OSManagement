# OCI Cloud Access information; uncomment and provide values
#target_region    = "eu-frankfurt-1"
#tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaa..."
#user_ocid        = "ocid1.user.oc1..aaaaaaa..."
#private_key_path = "<path to API private key>/oci_api_key.pem"
#fingerprint      = "<API key fingerprint>"

## all resources are created in this compartment; uncomment and provide values
#target_compartment_id = "ocid1.compartment.oc1..aaaaaaa..."
## SSH key for compute instance access
#ssh_public_key_path = "<path>/ocicloud_rsa.pub"
## Ignore tags that not added by Terraform
#ignore_defined_tags = ["Mandatory_Tags.CreatedOn", "Mandatory_Tags.Owner", "Mandatory_Tags.Schedule"]


availability_domain = "3"
shape = "VM.Standard3.Flex"

# when resources are provisioned the states must be "RUNNING"
# after successfull provisioning states can be set to "STOPPED" to save cost

# state of the golden instances
gi_state = "RUNNING"

# description of managed instance groups and managed instances
servers = [
    {group = "OracleLinux8_ManagedInstanceGroup1",  name = "Tokyo8",      os = "OracleLinux8", subnet = "public", state="RUNNING", count = 4},
    {group = "OracleLinux8_ManagedInstanceGroup2",  name = "Toronto8",    os = "OracleLinux8", subnet = "public", state="RUNNING", count = 3},
    {group = "OracleLinux9_ManagedInstanceGroup1",  name = "NewYork9",    os = "OracleLinux9", subnet = "public", state="RUNNING", count = 2},
    {group = "OracleLinux9_ManagedInstanceGroup2",  name = "London9",     os = "OracleLinux9", subnet = "public", state="RUNNING", count = 2},
    {group = "Windows_ManagedInstanceGroup",        name = "Windows2019", os = "Windows2019",  subnet = "public", state="RUNNING", count = 0},
  ]

# network
vcndef = {
  name     = "VCNPatchTrain"
  cidr     = ["10.0.0.0/16","192.168.0.0/16"]
  subnets = {
    private = { name = "private", cidr = "10.0.0.0/17",   private = true }
    public  = { name = "public",  cidr = "10.0.128.0/17", private = false }
  }
}

defined_tags = {
    "ResourceControl.dns"    = "true"
    "ResourceControl.keepup" = "false"
  }
