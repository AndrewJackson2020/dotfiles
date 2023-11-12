
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


## Future Development
- TODO track /etc/xrdp/sesman.ini in config files
- TODO Write better help documentation for CLI
- TODO Sunset bash scripts in installer in favor of archinstall
- TODO Incorporate build process to semi automatically deploy .iso publically
- TODO Incorporate archinstall config files into .iso
- Hyper V
    - TODO Get VM GUI working in Hyper V
    - TODO Build powershell script to bootstrap Hyper V VM