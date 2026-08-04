{ config, lib, pkgs, dlsFuncs, inputs, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;

  mkSymlinkPath = dlsFuncs.mkSymlinkPath mkOutOfStoreSymlink lib inputs.self;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlinkPath [
      ../../kitty/kitty.conf
    ]
  );
in
{
  programs.kitty.enable = true;

  xdg.configFile = confLinks;
}
