
{ lib, config, pkgs, ... }:

let
  terraform_src = pkgs.fetchzip {
    url = "https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_linux_amd64.zip";
    hash = "sha256-eoPAIM4FtC0fAwW851ouiZpL8hkQ/whKanI26xOX+9M=";
  };
  go_src = pkgs.fetchzip {
    url = "https://go.dev/dl/go1.22.0.linux-amd64.tar.gz";
    hash = "sha256-gRj8ZbcTc7rK8jVDxi13izHcIbbwjFx9hS4GIm7l9ks=";
  };
  get_files = x: map (y: x + "/" + y) (builtins.attrNames (lib.filterAttrs (n: v: v == "regular") (builtins.readDir (./home + x))));
  get_directories = x: builtins.concatLists (map (y: get_dotfiles (x + "/" + y)) (builtins.attrNames (lib.filterAttrs (n: v: v == "directory") (builtins.readDir (./home + x)))));
  get_dotfiles = x: map (y: y) (builtins.concatLists [(get_directories x) (get_files x)]);
  home_file = x: ./home + ("/" + x);
  files = get_dotfiles "";
  files_map = map (x: {"${x}".source = (home_file x);}) files;
in
{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.file = lib.mkMerge ([
    {".local/bin/terraform".source = terraform_src;} 
    {".local/go".source = go_src;}
  ] ++ files_map);

  programs.home-manager.enable = true;
}

