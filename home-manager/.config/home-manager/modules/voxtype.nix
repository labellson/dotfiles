{ config, lib, pkgs, dlsFuncs, inputs, ... }:

let
  inherit (inputs) voxtype;

  linkFile = dlsFuncs.makeLinkFile config.lib.file.mkOutOfStoreSymlink;
  confFiles = lib.map linkFile [
    "niri/voxtype.kdl"
  ];
  confLinks = lib.mergeAttrsList confFiles;
in
{
  imports = [ voxtype.homeManagerModules.default ];

  # Whisper example (default engine):
  programs.voxtype = {
    enable = true;
    package = voxtype.packages.${pkgs.stdenv.hostPlatform.system}.vulkan;
    model.name = "base.en";
    service.enable = true;
    settings = {
      hotkey.enabled = false;
      whisper.language = "en";
      audio.feedback ={
        enabled = true;
        theme = "default";
      };
    };
  };

  xdg.configFile = confLinks;
}
