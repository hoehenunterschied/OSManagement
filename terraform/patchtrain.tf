resource "random_string" "random" {
  length           = 6
  special          = false

  lifecycle {
    ignore_changes = [
      length,
      lower,
    ]
  }
}

resource "oci_identity_dynamic_group" "patchtrain_dynamic_group" {
    provider = oci.home
    #Required
    compartment_id = var.tenancy_ocid
    description = "PatchTrain"
    matching_rule = "Any {instance.compartment.id = '${local.work_compartment.id}'}"
    name = "patchtrain_dynamic_group_${random_string.random.result}"
}

resource "oci_identity_policy" "patchtrain_policy" {
    provider = oci.home
    #Required
    compartment_id = local.work_compartment.id
    description = "assign privileges to dynamic group ${oci_identity_dynamic_group.patchtrain_dynamic_group.name}"
    name = "PatchTrainPolicy"
    statements = [
                   "allow dynamic-group ${oci_identity_dynamic_group.patchtrain_dynamic_group.name} to use osms-managed-instances in compartment ${local.work_compartment.name}",
                   "allow dynamic-group ${oci_identity_dynamic_group.patchtrain_dynamic_group.name} to read instance-family in compartment ${local.work_compartment.name}"
                 ]
}

# iteration is over groups
resource "oci_osmanagement_managed_instance_group" "managed_instance_groups" {
    count = length(var.servers) # number of groups is length(var.servers), number of  instances is length(local.servers)
    #Required
    compartment_id    = local.work_compartment.id
    display_name      = var.servers[count.index].group
    os_family         = length(regexall("WINDOWS", upper(var.servers[count.index].os)))>0? "WINDOWS" : "LINUX"
}

# iteration is over instances
resource "oci_osmanagement_managed_instance_management" "managed_instance_management" {
  count = length(local.servers) # number of groups is length(var.servers), number of  instances is length(local.servers)
  managed_instance_id = oci_core_instance.managed_instances[count.index].id
  managed_instance_groups {
    id           = oci_osmanagement_managed_instance_group.managed_instance_groups[index(oci_osmanagement_managed_instance_group.managed_instance_groups.*.display_name, local.servers[count.index].group)].id
    display_name = oci_osmanagement_managed_instance_group.managed_instance_groups[index(oci_osmanagement_managed_instance_group.managed_instance_groups.*.display_name, local.servers[count.index].group)].display_name
  }
  depends_on = [time_sleep.wait_for_managed_instances]
}

