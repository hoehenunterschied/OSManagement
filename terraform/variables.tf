variable "target_region" {
  type = string
}
variable "tenancy_ocid" {
  description = "the Tenancy OCID"
  type = string
}
variable "user_ocid" {
  description = "the User OCID"
  type = string
}
variable "fingerprint" {
  description = "fingerprint of the OCI API key"
  type = string
}
variable "private_key_path" {
  description = "path to private key of the OCI API key"
  type = string
}
variable "target_compartment_id" {
  type = string
  description = "all resources are created in this compartment"
}
variable "availability_domain" {
  description = "the availability domain referenced by a number. Range is 1..<number of ADs in region>."
  type = string
  default = "3"
  validation {
    condition = contains(["1","2","3"],var.availability_domain)
    error_message = "The availability_domain is out of range."
  }
}
variable "ignore_defined_tags" {
  description = "Ignore Tags not added by Terraform"
  type = list(string)
  default = []
}
variable "gi_state" {
  description = "the target state for golden instances"
  default = "RUNNING"
}
variable "shape" {
  type = string
  default = "VM.Standard3.Flex"
}
variable "defined_tags" {
  description = "defined_tags for compute intances"
  type = map
}
# to work with OCI Resource Manager Stack as well as standalone
# we define two variables for the SSH public key and a path to a public key
# ssh_public_key is set by OCI Stack. If ssh_public_key is empty,
# ssh_public_key_path is evaluated.
variable "ssh_public_key" {
  description = "public SSH"
  type = string
  default = ""
}
variable "ssh_public_key_path" {
  description = "public SSH key location"
  type = string
}
variable "vcndef" {
  description = "basic parameters for a VCN with subnets"
  type = object({
    name = string
    cidr = list(string)
    subnets = map(object({
      name = string
      cidr = string
      private = bool
    }))
  })
}
variable "servers" {
  type = list(object({
    group  = string,
    name   = string,
    os     = string,
    subnet = string,
    state  = string,
    count  = number
  }))
  default = [
    {group = "OracleLinux8_ManagedInstanceGroup1",  name = "Tokyo8",      os = "OracleLinux8", subnet = "public", state="RUNNING", count = 4},
    {group = "OracleLinux8_ManagedInstanceGroup2",  name = "Toronto8",    os = "OracleLinux8", subnet = "public", state="RUNNING", count = 3},
    {group = "OracleLinux9_ManagedInstanceGroup1",  name = "NewYork9",    os = "OracleLinux9", subnet = "public", state="RUNNING", count = 2},
    {group = "OracleLinux9_ManagedInstanceGroup2",  name = "London9",     os = "OracleLinux9", subnet = "public", state="RUNNING", count = 2},
    {group = "Windows_ManagedInstanceGroup",        name = "Windows2019", os = "Windows2019",  subnet = "public", state="RUNNING", count = 0},
  ]
}
#variable "golden_instances" {
#  description = "list of computes to provision"
#  type = list(object({
#    name   = string
#    os     = string
#    subnet = string
#    state  = string
#  }))
#}
variable "python_update_software_source_script_path" {
  description = "Terraform will generate the python script at this path"
  type = string
  default = "../python/update_software_source.py"
}
variable "python_update_instances_script_path" {
  description = "Terraform will generate the python script at this path"
  type = string
  default = "../python/update_instances.py"
}
variable "bash_instancestate_script_path" {
  description = "Terraform will generate the bash script at this path"
  type = string
  default = "../misc/instancestate.bash"
}
