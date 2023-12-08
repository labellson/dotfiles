{ config, lib, pkgs, ... }:

{
  programs.bash = {
      enable = true;
    };

  programs.fish = {
    enable = true;
  };

  home.file = {
    ".bashrc".source = ../../../../bash/.bashrc;
  };
}
