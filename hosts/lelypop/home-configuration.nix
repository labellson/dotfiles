{ config, lib, pkgs, ... }:

{
  imports = [
    ./fish.nix
  ];

  home.packages = with pkgs; [
    pavucontrol

    pgcli

    obsidian
    vlc
    evince

    dconf

    thunar

    go-grip # grip markdown preview
    pandoc
    texliveFull
    xan

    databricks-cli
    azure-cli

    teams-for-linux
    snx-rs
  ];
}
