<#
.SYNOPSIS
CLI to assist in building Windows based VM's

.DESCRIPTION
USAGE
    ./build_vm_hyper_v.ps1 <command>

COMMANDS
    setup_vm                        Command to create initial VM with boot drive mounted
    change_boot_priority_to_disk    Command to remove boot drive from VM
    destroy_vm                      Command to destroy VM
    ssh_to_vm                       Command to SSH into VM

#>
param(
  [Parameter(Position=0, Mandatory=$True)]
  [ValidateSet(
    "setup_vm", "change_boot_priority_to_disk", "destroy_vm", "ssh_to_vm")]
  [string]$Command
)
#Requires -RunAsAdministrator

$hard_drive_location = "C:\ProgramData\Microsoft\Windows\Virtual Hard Disks\arch_linux_hd.vhdx"

function setup_vm {

    $ErrorActionPreference = "Stop"

    New-VM `
        -Name arch_linux_vm `
        -MemoryStartupBytes 8GB `
        -Generation 2 `
        -Switch "Default Switch" `
        -Path "C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines"

    New-VHD `
        -SizeBytes 50GB `
        -Path $hard_drive_location

    Add-VMHardDiskDrive `
        -VMName arch_linux_vm `
        -ControllerType SCSI `
        -Path $hard_drive_location

    Add-VMDvdDrive `
        -VMName arch_linux_vm `
        -Path "C:\Users\spike\Downloads\archlinux-2023.11.01-x86_64.iso"

    Set-VMFirmware `
        -VMName arch_linux_vm `
        -EnableSecureBoot Off

    $dvd_drive = Get-VMDvdDrive `
        -VMName arch_linux_vm

    Set-VMFirmware `
        -VMName arch_linux_vm `
        -FirstBootDevice $dvd_drive

    Set-VMProcessor `
        arch_linux_vm `
        -Count 8

    Start-VM `
        -Name arch_linux_vm
}

function change_boot_priority_to_disk {

    $hdd = Get-VMHardDiskDrive `
        -VMName arch_linux_vm

    Set-VMFirmware `
        -VMName arch_linux_vm `
        -FirstBootDevice $hdd
    Stop-VM `
        -VMName arch_linux_vm
    Start-VM `
        -VMName arch_linux_vm
}

function ssh_to_vm {
    $ip_address = (get-vm -Name arch_linux_vm).NetworkAdapters.IPAddresses[0]
    # scp -r ./andrew_arch_iso/airootfs/root/installers/archinstall_installer "root@${ip_address}:~/"  
    ssh "root@${ip_address}"
}


function destroy_vm {

    Stop-VM `
        -Name arch_linux_vm

    Remove-VM `
        -Name arch_linux_vm `
        -Force

    Remove-Item "C:\ProgramData\Microsoft\Windows\Virtual Hard Disks\arch_linux_hd.vhdx"
}

switch ($Command) {
    "setup_vm" {
        setup_vm
    } 
    "change_boot_priority_to_disk" {
        change_boot_priority_to_disk
    }
    "ssh_to_vm" {
        ssh_to_vm
    }
    "destroy_vm" {
        destroy_vm
    }
}