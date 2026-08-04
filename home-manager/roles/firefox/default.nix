{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    pywalfox-native
  ];
}
