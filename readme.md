
# Dotfiles

## Summary
This repo stores all of my linux config. This includes dotfiles which are deployed via stow and a 
custom ISO installer image created via archiso.

## Useful commands

```bash
archinstall \
    --config "./user_configuration.json" \
    --creds "./user_credentials.json"
```

## References
- Used this link to get i3 to work with VirtualBox/xRDP
    - https://gist.github.com/valorad/7fd3e4a7fb4481f1eb77ded42a72537d

## Design Decisions
- TODO Depricate VirtualBox stuff?
- TODO Sunset bash scripts in installer in favor of archinstall?

## Future Development
- TODO Write better help documentation for CLI
- TODO Incorporate build process to semi automatically deploy .iso publically
- TODO Incorporate archinstall config files into .iso
- TODO Need way to ensure home is only executed by user, system is only executed by root for config file terraform
- TODO modify andrew_arch_iso\airootfs\root\installers\archinstall_installer\install.sh script to have unix line endings
- Hyper V
    - TODO HyperV VM names can be duplicate, should ccheck for preexisting VM's before allowing to create new ones
    - TODO Change Hyper V VM data and VM files path
- TODO Add aj-os-arch-repo to pacman.conf

## Completed Development
- track /etc/xrdp/sesman.ini in config files
- Hyper V
    - TODO Get VM GUI working in Hyper V
    - TODO Build powershell script to bootstrap Hyper V VM
