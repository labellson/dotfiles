{ config, lib, pkgs, ... }:


let
  # import some useful functions
  inherit (config.lib.file) mkOutOfStoreSymlink;

  link = name: mkOutOfStoreSymlink name;
in
{
  home.packages = with pkgs; [
    # a tinted theming cli tool
    tinty
  ];

  xdg.dataFile = {
    "tinted-theming/tinty/custom-schemes/base16/oksolar-light.yaml".source = link ./base16/oksolar-light.yaml;
    "tinted-theming/tinty/custom-schemes/base16/oksolar-dark.yaml".source = link ./base16/oksolar-dark.yaml;
  };
}
