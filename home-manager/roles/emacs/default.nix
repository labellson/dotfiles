{ config, lib, pkgs, pkgsUnstable, ... }:

{
  home.packages = with pkgs; [
    pkgsUnstable.emacs-pgtk  # with native wayland support
    nil
    nodejs # just to install lsp-servers

    # needed by doom emacs
    fd
    libtool  # needed to compile vterm
    gcc
    gnumake
    cmakeMinimal
    (aspellWithDicts (dicts: with dicts; [en es]))
    shellcheck
    nixfmt
  ];
}
