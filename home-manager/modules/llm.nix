{ config, lib, pkgs, pkgsUnstable, dlsFuncs, ... }:

let
  mkSymlink = dlsFuncs.mkSymlink config.lib.file.mkOutOfStoreSymlink;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlink [
      "opencode/opencode.json"
    ]
  );
in
{
  home.packages = with pkgsUnstable; [
    llama-cpp-vulkan
    github-copilot-cli
    # cli proxy that reduces LLM token consumption on common dev commands (ex:
    # bash tool). Install later with
    # rtk init -g --opencode
    rtk

    nodejs
    pnpm
  ];

  home.sessionVariables = {
    OPENCODE_MODEL = "github-copilot/claude-sonnet-5";
    OPENCODE_SMALL_MODEL = "github-copilot/gpt-5.6-luna";
  };

  programs.opencode.enable = true;
  programs.opencode.package = pkgsUnstable.opencode;

  programs.uv = {
    enable = true;
    tool.packages = [
      "headroom-ai[all]"
      # initialise after the installation
      # run: serena init
      "serena-agent"
      # to register to the agent assistant
      # run: graphify install opencode
      # always use the graph: graphify opencode install
      "graphifyy"
    ];
  };

  #
  # other tools not in nix
  #
  # https://github.com/Egonex-AI/Understand-Anything
  # curl -fsSL https://raw.githubusercontent.com/Egonex-AI/Understand-Anything/main/install.sh | bash
  #
  # https://github.com/JuliusBrussee/caveman
  # curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash
  #

  xdg.configFile = confLinks;
}
