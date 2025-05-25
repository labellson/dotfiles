{ config, pkgs, ... }:

{
  imports = [
    ./modules/shell.nix
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tmux
    mosh
    neovim
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nix/nix.conf".text = "extra-experimental-features = nix-command flakes";
    ".tmux.conf".source = ../../../tmux/.tmux.conf;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/labellson/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself and enable git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
