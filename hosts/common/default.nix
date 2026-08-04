{ config, lib, pkgs, ... }:

{
  imports = [
    ../../home-manager/modules/shell
    ../../home-manager/modules/kitty.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    btop
    killall
    ncdu

    tmux
    mosh
    neovim
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".tmux.conf".source = ../../tmux/.tmux.conf;
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -a '' -r";
    TERM = "kitty";
  };
}
