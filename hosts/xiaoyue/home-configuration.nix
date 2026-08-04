{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol

    obsidian
    vlc
    evince

    stremio-linux-shell

    ledger
    hledger
    tradingview
  ];
}
