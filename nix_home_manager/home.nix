{ config, pkgs, ... }:

{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # TODO Should build below by getting recursive list of files in home directory
  # TODO figure out how to loop through values and assign home file mappings dynamically
  # TODO Need to figure out how to get nix to pull terraform/go archives dynamically instead of store in repo/file

  home.file = {
    ".local/bin/terraform".source = ./home/.local/bin/terraform; 
    ".local/go/".source = ./home/.local/go; 
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
