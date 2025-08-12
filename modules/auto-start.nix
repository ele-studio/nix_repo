# modules/auto-start.nix
{ config, pkgs, ... }:

{
  # Ensure the necessary programs are installed
  home.packages = with pkgs; [
    hyprpaper
    hypridle
  ];

  # Hyprpaper wallpaper config
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/wesley/Pictures/wallpapers/default.png
    wallpaper = eDP-1,/home/wesley/Pictures/wallpapers/default.png
    wallpaper = DP-1,/home/wesley/Pictures/wallpapers/default.png
  '';

  # Hypridle config (optional, simple lock on idle)
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = hyprlock
      before_sleep_cmd = hyprlock
      ignore_dbus_inhibit = false
    }

    listener {
      timeout = 300
      on-timeout = hyprlock
      on-resume = echo "welcome back"
    }
  '';

  # User service for hyprpaper
  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprpaper wallpaper service";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # User service for hypridle
  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hypridle idle manager";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
