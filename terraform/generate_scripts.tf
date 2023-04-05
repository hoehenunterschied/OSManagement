# generate the python scripts
#   update_software_source.py : create a software source with packages from golden instance
#   update_instances.py       : update all managed instances of a managed instance group
#   instancestate.bash        : display lifecycle state of deployed instances

resource "local_file" "python_update_software_source" {
  filename = var.python_update_software_source_script_path
  content = templatefile("python_update_software_source.tftpl", {compartment_id = local.work_compartment.id, region = var.target_region})
}
resource "local_file" "python_update_instances" {
  filename = var.python_update_instances_script_path
  content = templatefile("python_update_instances.tftpl", {compartment_id = local.work_compartment.id, region = var.target_region})
}
resource "local_file" "bash_intancestate" {
  filename = var.bash_instancestate_script_path
  content = templatefile("bash_instancestate.tftpl", {compartment_id = local.work_compartment.id, region = var.target_region})
}
