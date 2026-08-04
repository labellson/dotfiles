{ config, lib, pkgs, ... }:

{
  # tailscale systray applet
  services.tailscale-systray.enable = true;
  services.trayscale.enable = true;
}
