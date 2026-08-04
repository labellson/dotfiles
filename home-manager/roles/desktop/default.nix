{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/wayland.nix
    ../../modules/niri.nix
    ../../modules/noctalia.nix
  ];
}
