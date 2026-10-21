{ config, lib, pkgs, ... }:

{
  # allow fontconfig to discover fonts installed through home.packages
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fantasque-sans-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.gohufont
    nerd-fonts.symbols-only
  ];
}
