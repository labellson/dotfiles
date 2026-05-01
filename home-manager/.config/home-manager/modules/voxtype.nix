{ config, lib, pkgs, pkgs-unstable, dlsFuncs, inputs, ... }:

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


  # HACK: needed because the service can't find the plugins library
  home.packages = with pkgs; [ alsa-plugins ];
  home.sessionVariables = {
    ALSA_PLUGIN_DIR = "${pkgs.alsa-plugins}/lib/alsa-lib";
  };

  programs.voxtype = {
    enable = true;
    package = pkgs-unstable.voxtype-onnx;
    engine = "parakeet";
    model.path = "/home/${config.home.username}/.local/share/voxtype/models/parakeet-tdt-0.6b-v3-int8";
    service.enable = false;
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
