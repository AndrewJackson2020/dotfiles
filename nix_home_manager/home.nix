{ config, pkgs, ... }:

{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.file = {
    ".xinitrc".source = ./home/.xinitrc; 
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
    ".zshrc".source = ./home/.zshrc; 
    "cli.sh".source = ./home/cli.sh; 
  };

  programs.home-manager.enable = true;
}
