

function setup_vm {

    New-VMSwitch `
        -Name arch_linux_switch `
        -SwitchType Internal 

    New-VM `
        -Name arch_linux_vm `
        -MemoryStartupBytes 8GB `
        -Switch arch_linux_switch `
        -Generation 2 `
        -Path .\VMData

    New-VHD `
        -SizeBytes 50GB `
        -Path .\VMs\arch_linux_hd.vhdx

    Add-VMHardDiskDrive `
        -VMName arch_linux_vm `
        -ControllerType SCSI `
        -Path .\VMs\arch_linux_hd.vhdx

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
}

function change_boot_priority_to_disk {

    $hdd = Get-VMHardDiskDrive `
        -VMName arch_linux_vm

    Set-VMFirmware `
        -VMName arch_linux_vm `
        -FirstBootDevice $hdd

}

function ssh_to_vm {

}


function destroy_vm {

    Remove-VMSwitch `
        -Name arch_linux_switch `
        -Force

    Remove-VM `
        -Name arch_linux_vm `
        -Force
}
