{ config, lib, pkgs, ... }:

{
  # let home manager start the X session
  xsession.enable = true;

  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "reset-background.sh" = ''
      #!/usr/bin/env sh
      feh --no-fehbg --bg-fill ~/.background-image
      '';
    };
    profiles = {
      "home"= {
        fingerprint = {
          DP1 = "00ffffffffffff0010acc2d054584630111d010380351e78eaad75a9544d9d260f5054a54b008100b300d100714fa9408180d1c00101565e00a0a0a02950302035000e282100001a000000ff004d59334e44393450304658540a000000fc0044454c4c205032343138440a20000000fd0031561d711c000a202020202020010202031bb15090050403020716010611121513141f2065030c001000023a801871382d40582c45000e282100001e011d8018711c1620582c25000e282100009ebf1600a08038134030203a000e282100001a7e3900a080381f4030203a000e282100001a00000000000000000000000000000000000000000000000000000000d8";
          eDP1 = "00ffffffffffff004d1053140000000028190104a52313780ede50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f40302035005ac210000018000000000000000000000000000000000000000000fe00313230334d814c513135364d31000000000002410328001200000a010a2020004a";
        };
        config = {
          HDMI1.enable = false;
          HDMI2.enable = false;
          VIRTUAL1.enable = false;
          eDP1.enable = false;
          DP2.enable = false;
          DP1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            gamma = "0.769:0.588:0.435";
            mode = "2560x1440";
            rate = "60.00";
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    (polybar.override {i3Support = true;})
    polybar-pulseaudio-control
    rofi
    rofi-bluetooth
    bc # needed by rofi-bluetooth

    arandr

    # polish
    # TODO: doesn't seem to work, not sure if only in wayland. Havn't tried in
    # X11 for a long time
    lxappearance
  ];
}
