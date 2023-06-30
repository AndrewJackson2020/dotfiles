# Dotfiles

Stow Command
```bash
stow -d ./home -t ~/ .
sudo stow -d ./grub_themes -t /boot/grub/themes .
sudo stow -d ./grub.d -t /etc/grub.d .
sudo stow -d ./etc_default -t /etc/default/ .
```

unstow command
```
stow -d ./home -t ~/ -D .
sudo stow -d ./grub_themes -t /boot/grub/themes -D .
sudo stow -d ./grub.d -t /etc/grub.d -D .
sudo stow -d ./etc_default -t /etc/default/ -D .
```
