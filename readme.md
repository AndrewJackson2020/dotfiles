
# Dotfiles
This repo stores all of my dotfiles.

## Initial Setup

```bash
set -e
curl https://raw.githubusercontent.com/CommanderKeynes/dotfiles/master/readme.md
curl https://raw.githubusercontent.com/CommanderKeynes/dotfiles/master/cli.sh

import ./cli.sh
```

Initial setup
```bash
set -e
pacman -S git
cd tmp
git clone https://github.com/CommanderKeynes/dotfiles.git
source ./cli.sh
initial_setup_2
```

Run after chrooting into partition
```bash

```

Teardown after exiting chroot
```bash
umount /mnt
reboot
```

