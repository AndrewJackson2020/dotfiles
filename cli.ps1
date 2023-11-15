<#
.SYNOPSIS
CLI to assist in building Windows based VM's

.DESCRIPTION
USAGE
    ./cli.ps1 <command>

COMMANDS
    hyperv      Commands related to managing HyperV VM's
    virtualbox  Commands related to managing Virtualbox VM's

#>
param(
  [Parameter(Position=0, Mandatory=$True)]
  [ValidateSet("hyperv", "virtualbox")]
  [string]$Command,

  [Parameter(Position=1, Mandatory=$False)]
  [string]$SubCommand
)

switch ($Command) {
    "hyperv"  {
        & ./cli/powershell/build_vm_hyper_v.ps1 $SubCommand
    }
    "virtualbox"  {
        & ./cli/powershell/build_vm_virtualbox.ps1 $SubCommand
    }
}