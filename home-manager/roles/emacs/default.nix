{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    emacs-pgtk  # with native wayland support
    git-lfs
    git-filter-repo
    nil
    nodejs # just to install lsp-servers

    # needed by doom emacs
    fd
    libtool
    gcc
    gnumake
    cmakeMinimal
    (aspellWithDicts (dicts: with dicts; [en es]))
    shellcheck
    nixfmt
  ];
}
