{ config, lib, pkgs, ... }:

{
  imports = [
    ./python.nix
  ];

  home.packages = with pkgs; [
    git-lfs
    git-filter-repo
    jq

    pre-commit

    # TODO: add podman when needed
  ];
}
