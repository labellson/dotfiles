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
    # cli proxy that reduces LLM token consumption on common dev commands (ex:
    # bash tool)
    rtk
  ];

  home.sessionVariables = {
    OPENCODE_MODEL = "github-copilot/claude-sonnet-5";
    OPENCODE_SMALL_MODEL = "github-copilot/gpt-5.6-luna";
  };

  programs.opencode.enable = true;

  xdg.configFile = confLinks;
}
