{ config, pkgs, ... }:

let
  inherit (pkgs)
    fetchzip
  ;
  terraform_src = fetchzip {
    url = "https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_linux_amd64.zip";
    hash = "sha256-eoPAIM4FtC0fAwW851ouiZpL8hkQ/whKanI26xOX+9M=";
  };
  go_src = fetchzip {
    url = "https://go.dev/dl/go1.22.0.linux-amd64.tar.gz";
    hash = "sha256-gRj8ZbcTc7rK8jVDxi13izHcIbbwjFx9hS4GIm7l9ks=";
  };
in
{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # TODO Should build below by getting recursive list of files in home directory
  # TODO figure out how to loop through values and assign home file mappings dynamically

  home.file = {

    ".local/bin/terraform".source = terraform_src; 
    ".local/go/".source = go_src;

    ".background".source = ./home/.background; 
    ".bashrc".source = ./home/.bashrc; 
    ".config/doom/config.el".source = ./home/.config/doom/config.el; 
    ".config/doom/init.el".source = ./home/.config/doom/init.el; 
    ".config/i3/config".source = ./home/.config/i3/config; 
    ".config/nvim/init.lua".source = ./home/.config/nvim/init.lua; 
    ".config/terminator/config".source = ./home/.config/terminator/config; 
    ".fehbg".source = ./home/.fehbg; 
    ".gitconfig".source = ./home/.gitconfig; 
    ".psqlrc".source = ./home/.psqlrc; 
    ".tmux.conf".source = ./home/.tmux.conf; 
    ".tmux.conf.local".source = ./home/.tmux.conf.local; 
    ".vimrc".source = ./home/.vimrc; 
    ".xinitrc".source = ./home/.xinitrc; 
    ".zshrc".source = ./home/.zshrc; 
    "cli.sh".source = ./home/cli.sh; 
  };

  programs.home-manager.enable = true;
}
