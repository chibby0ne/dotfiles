{
  config,
  lib,
  pkgs,
  ...
}:
{
  systemd.services.darkman = {
    wantedBy = [ "default.target" ];
    description = "Start darkman as daemon mode";
    path = [
      pkgs.bash
      pkgs.coreutils
      pkgs.mako
      pkgs.glib
      pkgs.neovim-remote
      pkgs.dbus
      pkgs.libnotify
      pkgs.darkman
    ];
    serviceConfig = {
      Type = "dbus";
      BusName = "nl.whynothugo.darkman";
      ExecStart = "${pkgs.darkman}/bin/darkman run";
      Restart = "on-failure";
      TimeoutStopSec = 15;
      Slice = "background.slice";
    };
  };
}
