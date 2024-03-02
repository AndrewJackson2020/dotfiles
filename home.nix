{ config, pkgs, ... }:

{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  home.stateVersion = "23.11"; # Please read the comment before changing.


  home.file = {
    ".xinitrc" = {
      source = ./home/.xinitrc; 
      target = "/.xinitrc";
    };
    ".fehbg" = {
      source = ./home/.fehbg; 
      target = "/.fehbg";
    };
    ".bashrc" = {
      source = ./home/.bashrc; 
      target = "/.bashrc";
    };
    ".tmux.conf.local" = {
      source = ./home/.tmux.conf.local; 
      target = "/.tmux.conf.local";
    };
    ".vimrc" = {
      source = ./home/.vimrc; 
      target = "/.vimrc";
    };
    ".zshrc" = {
      source = ./home/.zshrc; 
      target = "/.zshrc";
    };
    "cli.sh" = {
      source = ./home/cli.sh; 
      target = "/cli.sh";
    };
    ".background" = {
      source = ./home/.background; 
      target = "/.background";
    };
    ".psqlrc" = {
      source = ./home/.psqlrc; 
      target = "/.psqlrc";
    };
    ".gitconfig" = {
      source = ./home/.gitconfig; 
      target = "/.gitconfig";
    };
    ".tmux.conf" = {
      source = ./home/.tmux.conf; 
      target = "/.tmux.conf";
    };
    ".config/doom/config.el" = {
      source = ./home/.config/doom/config.el; 
      target = "/.config/doom/config.el";
    };
    ".config/doom/init.el" = {
      source = ./home/.config/doom/init.el; 
      target = "/.config/doom/init.el";
    };
    ".config/i3/config" = {
      source = ./home/.config/i3/config; 
      target = "/.config/i3/config";
    };
    ".config/terminator/config" = {
      source = ./home/.config/terminator/config; 
      target = "/.config/terminator/config";
    };
    ".config/nvim/init.lua" = {
      source = ./home/.config/nvim/init.lua; 
      target = "/.config/nvim/init.lua";
    };

  };


  programs.home-manager.enable = true;
}
