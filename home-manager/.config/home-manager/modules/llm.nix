{ config, lib, pkgs, pkgs-unstable, dls, ... }:

let
  # import some useful functions
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) map mergeAttrsList;

  link = name: mkOutOfStoreSymlink (dls.toSrcFile name);

  # use previous functions to create helper functions to create attrSets
  linkFile = name: {
    ${name}.source = link name;
  };

  # declare the config files to link
  confFiles = map linkFile [
    "opencode/opencode.json"
  ];

  confLinks = mergeAttrsList confFiles;
in
{
  home.packages = with pkgs-unstable; [
    llama-cpp-vulkan
    github-copilot-cli
  ];

  programs.opencode.enable = true;

  xdg.configFile = confLinks;
}
