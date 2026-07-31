{ config, lib, pkgs, dlsFuncs, inputs, ... }:
#
# NOTE: niri is installed by the system if using nixos
#


let
  mkSymlink = dlsFuncs.mkSymlink config.lib.file.mkOutOfStoreSymlink;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlink [
      "niri/config.kdl"
    ]
  );
in
{
  xdg.configFile = confLinks;

  home.packages = with pkgs; [
    # niri full screen manager. Solves an issue when making window fullscreen
    inputs.nfsm-flake.packages.${stdenv.hostPlatform.system}.nfsm
    inputs.nfsm-flake.packages.${stdenv.hostPlatform.system}.nfsm-cli
  ];
}
