{ config, lib, pkgs, ... }:

{
  imports = [
    ./fish.nix
  ];

  # let home manager start the X session
  xsession.enable = true;

  # allow fontconfig to discover fonts installed through home.packages
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    ripgrep
    killall
    gnupg
    mosh

    firefox
    obsidian
    vlc
    ncdu

    emacs
    neovim
    nil  # nix language server

    # neede by doom emacs
    fd
    libtool
    gcc
    gnumake
    cmakeMinimal
    (aspellWithDicts (dicts: with dicts; [en es]))
    shellcheck
    nixfmt

    # i like to have it installed
    (python313.withPackages(ps: with ps; [requests ipython]))

    stremio-linux-shell
    steam

    fantasque-sans-mono
  ];
}
