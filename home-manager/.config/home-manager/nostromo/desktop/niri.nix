{ config, lib, pkgs, dlsFuncs, inputs, ... }:
#
# NOTE: niri is installed by the system if using nixos
#


let
  linkFile = dlsFuncs.makeLinkFile config.lib.file.mkOutOfStoreSymlink;
  confFiles = lib.map linkFile [
    "niri/config.kdl"
  ];
  confLinks = lib.mergeAttrsList confFiles;
in
{
  xdg.configFile = confLinks;

  home.packages = with pkgs; [
    # niri full screen manager. Solves an issue when making window fullscreen
    inputs.nfsm-flake.packages.${stdenv.hostPlatform.system}.nfsm
    inputs.nfsm-flake.packages.${stdenv.hostPlatform.system}.nfsm-cli
  ];
}
