
# Dotfiles
This repo stores all of my dotfiles.

## Initial Setup


ssh into vm
```bash
rm /home/andrew/.ssh/known_hosts
ssh -p 2222 root@127.0.0.1
```

Detach usb
```bash
VBoxManage shutdown archvm
VBoxManage modifyvm archvm \
    --boot1 disk \
    --boot2 dvd \
    --boot3 none \
    --boot4 none
VBoxManage startvm archvm \
    --type headless
```

Destroy VM
```bash
rm `pwd`/archvm/archvm_DISK.vdi 
VBoxManage shutdown archvm
VBoxManage unregistervm archvm --delete
```

```bash
curl https://raw.githubusercontent.com/CommanderKeynes/dotfiles/master/system_installs.txt
curl https://raw.githubusercontent.com/CommanderKeynes/dotfiles/master/cli.sh

source ./cli.sh
initial_setup
```

