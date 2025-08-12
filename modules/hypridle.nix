{ pkgs, ... }:

{
  home.packages = [ pkgs.hypridle ];

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = hyprlock
      before_sleep_cmd = hyprlock
      ignore_dbus_inhibit = false
    }

    listener {
      timeout = 300
      on-timeout = hyprlock
    }

    listener {
      timeout = 600
      on-timeout = systemctl suspend
    }
  '';
}
