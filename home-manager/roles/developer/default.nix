{ config, lib, pkgs, ... }:

{
  imports = [
    ./python.nix
  ];

  home.packages = with pkgs; [
    git-lfs
    git-filter-repo
    jq

    # TODO: add podman when needed
  ];
}
