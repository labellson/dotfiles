{ config, pkgs, ... }:

{
  imports = [
    ../modules/shell.nix
    ../commons.nix
    ./fish.nix
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # configure the username and all that things
  home.username = "labellson";
  home.homeDirectory = "/Users/labellson";

  # allow fontconfig to discover fonts installed through home.packages
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
    mosh

    neovim
    emacs-pgtk
    nil

    # fonts
    fantasque-sans-mono
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself and enable git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
