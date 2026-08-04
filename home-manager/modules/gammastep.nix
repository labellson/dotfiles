{ config, lib, pkgs, ... }:

{
  services.gammastep = {
    enable = true;
    latitude = 51.9;
    longitude = 4.5;
    provider = "manual";
    temperature.day = 5700;
    temperature.night = 3500;
    settings = {
      general = {
        gamma = 0.8;
      };
    };
  };
}
