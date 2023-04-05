#output "oracle-linux-8-latest-name" {
#  value = data.oci_core_images.OracleLinux8.images.0.display_name
#}
#
#output "oracle-linux-8-latest-id" {
#  value = data.oci_core_images.OracleLinux8.images.0.id
#}
#
#output "oracle-linux-9-latest-name" {
#  value = data.oci_core_images.OracleLinux9.images.0.display_name
#}
#
#output "oracle-linux-9-latest-id" {
#  value = data.oci_core_images.OracleLinux9.images.0.id
#}
#
#output "oracle-ubuntu-20-latest-name" {
#  value = data.oci_core_images.Ubuntu20.images.0.display_name
#}
#
#output "oracle-ubuntu-20-latest-id" {
#  value = data.oci_core_images.Ubuntu20.images.0.id
#}
#
#output "oracle-ubuntu-22-latest-name" {
#  value = data.oci_core_images.Ubuntu22.images.0.display_name
#}
#
#output "oracle-ubuntu-22-latest-id" {
#  value = data.oci_core_images.Ubuntu22.images.0.id
#}
#
#output "oracle-windows2019-latest-name" {
#  value = data.oci_core_images.Windows2019.images.0.display_name
#}
#
#output "oracle-windows2019-latest-id" {
#  value = data.oci_core_images.Windows2019.images.0.id
#}

output "target_compartment_name" {
  value = local.work_compartment.name
}

