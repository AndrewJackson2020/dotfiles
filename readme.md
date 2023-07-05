
# Dotfiles
This repo stores all of my dotfiles.

## Initial Setup
Create VM
```bash
VBoxManage createvm \
    --name archvm \
    --ostype Arch_64 \
    --register
VBoxManage modifyvm archvm \
    --memory 8000
VBoxManage createhd \
    --filename `pwd`/archvm/archvm_DISK.vdi \
    --size 80000 rl https://raw.githubusercontent.com/CommanderKeynes/dotfiles/mast
~                              |    er/cli.sh
\
    --format VDI
VBoxManage storagectl archvm \
    --name "SATA Controller" \
    --add sata \
    --controller IntelAhci
VBoxManage storageattach archvm \
    --storagectl "SATA Controller" \
    --port 0 \
    --device 0 \
    --type hdd \
    --medium  `pwd`/archvm/archvm_DISK.vdi
VBoxManage storagectl archvm \
    --name "IDE Controller" \
    --add ide \
    --controller PIIX4 
VBoxManage storageattach archvm \
    --storagectl "IDE Controller" \
    --port 1 \
    --device 0 \
    --type dvddrive \
    --medium ~/Downloads/archlinux-2023.07.01-x86_64.iso
VBoxManage modifyvm archvm \
    --boot1 dvd \
    --boot2 disk \
    --boot3 none \
    --boot4 none 
VBoxManage modifyvm archvm \
    --nic1 bridged \
    --bridgeadapter1 wlan0
VBoxManage startvm archvm \
    --type headless

VBoxManage unregistervm archvm --delete
```

```bash
curl https://raw.githubusercontent.com/CommanderKeynes/dotfiles/master/system_install.txt
curl https://raw.githubusercontent.com/CommanderKeynes/dotfiles/master/cli.sh

import ./cli.sh
```

