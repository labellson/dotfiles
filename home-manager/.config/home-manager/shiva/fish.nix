{ config, lib, pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake ~/.dotfiles#dani@shiva";
      gcm = "git commit -m";
      gc = "git checkout";
      gp = "git push";
      gpo = "git push origin";
      gpl = "git pull";
      gplo = "git pull origin";
      gploc = "git pull origin (git branch --show-current)";
      gf = "git fetch";
      gfo = "git fetch origin";
      gs = "git status";
      glol = "git log --oneline --decorate --graph";
      glola = "git log --oneline --decorate --graph --all";
    };
  };
}
