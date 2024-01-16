{ config, lib, pkgs, ... }:

{
  imports = [
    ../commons.nix
    ./fish.nix
  ];

  # configure the username and all that things
  home.username = "labellson";
  home.homeDirectory = "/Users/labellson";
}
