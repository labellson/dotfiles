{ config, lib, pkgs, pkgs-unstable, dlsFuncs, ... }:

let
  linkFile = dlsFuncs.makeLinkFile config.lib.file.mkOutOfStoreSymlink;
  confFiles = lib.map linkFile [
    "opencode/opencode.json"
  ];
  confLinks = lib.mergeAttrsList confFiles;
in
{
  home.packages = with pkgs-unstable; [
    llama-cpp-vulkan
    github-copilot-cli
  ];

  programs.opencode.enable = true;

  xdg.configFile = confLinks;
}
