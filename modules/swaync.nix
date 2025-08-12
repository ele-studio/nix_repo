{ pkgs, ... }:

{
  home.packages = [
    pkgs.swaynotificationcenter
  ];

  # Optional: start swaync when your session starts
  systemd.user.services.swaync = {
    Unit = {
      Description = "Sway Notification Center";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.configFile."swaync/config.json".text = builtins.toJSON {
    positionX = "right";
    positionY = "top";
    layer = "overlay";
    control-center-margin-top = 40;
    control-center-width = 500;
    control-center-height = 600;
    widget-config = {
      "dnd" = { enabled = true; };
      "mpris" = { enabled = true; };
    };
  };
}
