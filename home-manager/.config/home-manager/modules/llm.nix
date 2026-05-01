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

  home.sessionVariables = {
    OPENCODE_MODEL = "github-copilot/claude-sonnet-4.6";
    OPENCODE_SMALL_MODEL = "github-copilot/claude-haiku-4.5";
  };

  programs.opencode.enable = true;

  xdg.configFile = confLinks;
}
