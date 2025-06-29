{
  config,
  pkgs,
  lib,
  ...
}:
{
  systemd.services.darkman = {
    wantedBy = [ "multi-user.target" ];
    description = "Start darkman as daemon mode";
    serviceConfig = {
      type = "forking";
      ExecStart = "darkman run";
    };
  };
}
