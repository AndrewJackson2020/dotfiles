
```bash
PATH=$PATH:~/.nix-profile/bin
export NIX_SSL_CERT_FILE=/etc/ssl/cert.pem
export NIX_CONFIG="experimental-features = nix-command flakes"
home-manager switch --flake -f ./home.nix
```
