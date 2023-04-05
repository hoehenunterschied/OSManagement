
locals {
  work_compartment = data.oci_identity_compartment.target_compartment
  availability_domain_number = tonumber(var.availability_domain) <= length(data.oci_identity_availability_domains.ads.availability_domains) ? tonumber(var.availability_domain) - 1 : 0
  availability_domain_name = data.oci_identity_availability_domains.ads.availability_domains[local.availability_domain_number].name
  os_images = {
    "OracleLinux8" = data.oci_core_images.OracleLinux8.images.0.id
    "OracleLinux9" = data.oci_core_images.OracleLinux9.images.0.id
    "Ubuntu20"     = data.oci_core_images.Ubuntu20.images.0.id
    "Ubuntu22"     = data.oci_core_images.Ubuntu22.images.0.id
    "Windows2019"  = data.oci_core_images.Windows2019.images.0.id
  }

  servers = flatten([
    for server in var.servers : [
      for i in range(1, server.count+1) : {
        group   = server.group
        name    = "${server.name}-${i}"
        os      = server.os
        subnet  = server.subnet
        state   = server.state
        item_no = "${server.os} no.: ${i} out of ${server.count}"
      }
    ]
  ])

  golden_instances = [
    {name = "OL8GoldenInstance1", os = "OracleLinux8", subnet = "public", state = var.gi_state},
    {name = "OL8GoldenInstance2", os = "OracleLinux8", subnet = "public", state = var.gi_state},
    {name = "OL9GoldenInstance1", os = "OracleLinux9", subnet = "public", state = var.gi_state},
    {name = "OL9GoldenInstance2", os = "OracleLinux9", subnet = "public", state = var.gi_state},
  ]
}


