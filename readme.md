
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
- TODO Write better help documentation for CLI
- TODO Separate stow stuff from other stuff
- TODO Move non "prod" stuff into separate repo(s)
- TODO Build powershell script to bootstrap Hyper V VM
- TODO Incorporate build process to semi automatically deploy .iso publically
- TODO Incorporate archinstall config files into .iso