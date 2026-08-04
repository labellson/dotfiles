{ config, lib, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    tray.enable = true;
    settings.devices = {
      "Taiga S6 Lite" = {
        id = "PCTAJAA-AIH4CCZ-PDUPFE7-RMYU2AE-SSQTFLO-Q3IQZEW-H7OCH47-JVILIQH";
      };
      "Tundra 13 mini" = {
        id = "472BSW5-7SUTFWA-ABZ6A2L-PQGVUME-UMMCIJX-WLSGQPA-DKAWSAT-DK7EAQU";
      };
      "Abyssal" = {
        id = "5UWO2RU-Y2LBY6G-G577UKH-OMQRRHO-H6PIJER-Z2LUPL3-6CXH642-AYZ5EAY";
      };
      "Nostromo" = {
        id = "TCJDGZ4-BQEHS4D-JIIT4TF-SG7GRWH-QPVH2HT-DNWY6B6-ST77S5M-SIFLUQV";
      };
    };
    settings.folders = {
      "my-notes" = {
        path = "/home/${config.home.username}/syncthing/my-notes";
        devices = [ "Taiga S6 Lite" "Tundra 13 mini" "Abyssal" "Nostromo" ];
      };
      "my-finance" = {
        path = "/home/${config.home.username}/syncthing/my-finance";
        devices = [ "Taiga S6 Lite" "Tundra 13 mini" "Abyssal" "Nostromo" ];
      };
    };
  };
}
