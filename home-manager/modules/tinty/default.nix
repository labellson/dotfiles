{ config, lib, pkgs, dlsFuncs, inputs, ... }:


let
  # import some useful functions
  inherit (config.lib.file) mkOutOfStoreSymlink;

  link = name: mkOutOfStoreSymlink name;
  mkSymlinkPath = dlsFuncs.mkSymlinkPath mkOutOfStoreSymlink lib inputs.self;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlinkPath [
      ../../../tinted-theming/tinty/config.toml
    ]
  );
in
{
  home.packages = with pkgs; [
    # a tinted theming cli tool
    tinty
  ];

  xdg.configFile = confLinks;

  xdg.dataFile = {
    "tinted-theming/tinty/custom-schemes/base16/oksolar-light.yaml".source = link ./base16/oksolar-light.yaml;
    "tinted-theming/tinty/custom-schemes/base16/oksolar-dark.yaml".source = link ./base16/oksolar-dark.yaml;
  };
}
