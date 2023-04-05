# Oracle OCI OS Management

## Abstract

The Oracle OCI [OS Management](https://docs.oracle.com/en-us/iaas/os-management/osms/osms-overview.htm#about-osms) Service allows users to control the update process of Oracle Cloud Infrastructure (OCI) [compute instances](https://docs.oracle.com/en-us/iaas/Content/Compute/Concepts/computeoverview.htm). By default, the update of a compute instance installs the latest available packages and patches. Just installing what is available might impact critical installed applications. It might also be desirable to keep the number of configuration variants low by ensuring all or groups of instances have the exact same versions of packages and patches installed. This can be achieved with OS Management.

## Managed Instances, Managed Instance Groups and Software Sources

**Managed Instances** are compute instances under control of OS Management.

**Managed Instance Groups** group instances for updates.

**Software Sources** are loaded with lists of packages and patches, including their versions. Software Sources are associated with Managed Instances, not with Managed Instance Groups. This allows to group Managed Instances of different types into the same Managed Instance Group. An update command can be send to the group which then updates each Managed Instance from its associated Software Source.

**Golden Instance** A golden instance is compute instance which has been prepared to have the packages and patches installed which will later be installed on managed instances. In other words, tests are made on the golden instance to make sure the installed packages and patches do work with the applications run by managed instances. When a healthy state has been achieved on the golden instance, a software source is loaded with the list of the golden instances packages and patches.

## Prerequisites
[Terraform](https://developer.hashicorp.com/terraform/downloads), Python

## Resources created
### Resource created by Terraform
* Compute Instances - Managed Instances
* Compute Instances - Golden Instances
* Managed Instance Groups
* Managed Instance Management (association of Manged Instance to Managed Instance Group)
* Dynamic Group
* Policy
* Virtual Cloud Network
* private and public Subnet
* private and public Security Lists
* local bash script to query the lifecycle state of compute instances
* Python script to create a software source and associate it with the managed instances of a managed instance group
* Python script to update a managed instance group

### Resources created by script
* Software Sources - the Python script `update_software_source.py` is created by Terraform from a template. The script takes a `managed instance group` and a `golden instance` as parameters, creates a software sources, updates it with the list of packages and patches from the golden instance and associates the managed instances of the managed instance group with the software source.

## Architecture
Four Managed Instance Groups are created to test two different versions of operating systems (Oracle Linux 8, Oracle Linux 9) and different types of updates (`Ksplice` and `All`):
| | KSplice Update | All Update |
| - | - | - |
| Oracle Linux 8 | OracleLinux8_ManagedInstanceGroup1 | OracleLinux8_ManagedInstanceGroup2|
| Oracle Linux 9 | OracleLinux9_ManagedInstanceGroup1 | OracleLinux9_ManagedInstanceGroup2|

In the current incarnation of this demo, instance names are a combination of a city and a number:
* `Tokyo` for `OracleLinux8_ManagedInstanceGroup1`
* `Toronto` for `OracleLinux8_ManagedInstanceGroup2`
* `NewYork` for `OracleLinux9_ManagedInstanceGroup1`
* `London` for `OracleLinux9_ManagedInstanceGroup2`

Software Sources are named by appending the suffix `_SoftwareSource` to the Managed Instance Group name:
* `OracleLinux8_ManagedInstanceGroup1_SoftwareSource`
* `OracleLinux8_ManagedInstanceGroup2_SoftwareSource`
* `OracleLinux9_ManagedInstanceGroup1_SoftwareSource`
* `OracleLinux9_ManagedInstanceGroup2_SoftwareSource`

## Directory Structure
#### Subdirectory html
* `index.html`
* `index2.html`

open in a web browser to show screen snapshots from the created environment
#### Subdirectory misc
* `OS Management.pdf` - a handwritten script to describe what OS Management does
* `OSManagement.drawio` - architecture diagramm
* `checkdns.bash` - can be ignored
* `instancestate.bash` **will be created by terraform apply** shows the lifecycle state of managed and golden instances
#### Subdirectory python and python/batch
* `python/update_software_source.py` Python script to update (destroy and create) a software source from a golden instance. **This file will be created by terraform apply**
* `python/update_instances.py` Python script to update the instances of a managed instance group
* `python/batch/update_software_sources.bash` updates (destroys and creates) 4 software sources for the 4 managed intance groups
* `python/batch/update_instances.bash` applies `Ksplice` and `All` updates to managed intance groups
#### Subdirectory terraform
* all Terraform resources and file templates to let Terraform create local scripts.





