{ config, lib, pkgs, ... }:

{
  imports = [
    ./fish.nix
  ];

  # configure the username and all that things
  home.username = "labellson";
  home.homeDirectory = "/Users/labellson";
}
