# TODO Should build below by getting recursive list of files in home directory

{ lib, config, pkgs, ... }:

let
  inherit (pkgs)
    fetchzip
  ;
  inherit (lib)
    mkMerge
  ;
  terraform_src = fetchzip {
    url = "https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_linux_amd64.zip";
    hash = "sha256-eoPAIM4FtC0fAwW851ouiZpL8hkQ/whKanI26xOX+9M=";
  };
  go_src = fetchzip {
    url = "https://go.dev/dl/go1.22.0.linux-amd64.tar.gz";
    hash = "sha256-gRj8ZbcTc7rK8jVDxi13izHcIbbwjFx9hS4GIm7l9ks=";
  };
  get_dotfiles = x: map (y: x + "/" + y) (builtins.attrNames (lib.filterAttrs (n: v: v == "regular") (builtins.readDir (./home + x))));
  home_file = x: ./home + ("/" + x);
  files = builtins.concatLists [
    (get_dotfiles "") 
    (get_dotfiles "/.config/doom") 
    (get_dotfiles "/.config/i3") 
    (get_dotfiles "/.config/nvim")
    (get_dotfiles "/.config/terminator")
  ];
  files_map = map (x: {"${x}".source = (home_file x);}) files;
in
{
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  home.stateVersion = "23.11"; # Please read the comment before changing.


  home.file = mkMerge ([
    {".local/bin/terraform".source = terraform_src;} 
    {".local/go".source = go_src;}
  ] ++ files_map);

  programs.home-manager.enable = true;
}

