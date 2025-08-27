{ config, pkgs, root, ... }:

{
  home.file."bin/memory_usage.sh" = {
    source = root + "/scripts/waybar/memory_usage.sh";
    executable = true;
  };

  home.file."bin/power.sh" = {
    source = root + "/scripts/custom/power.sh";
    executable = true;
  };

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        height = 26;
        spacing = 8;
        margin-top = 5;
        margin-right = 5;
        margin-left = 5;

        modules-left = [
          "custom/rofi"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "custom/memory"
          "pulseaudio"
          "battery"
          "tray"
        ];

        "custom/rofi" = {
          format = "";
          on-click = "${config.home.homeDirectory}/bin/power.sh";
          escape = true;
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          active-only = false;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "󰈹";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
          };
        };

        "hyprland/window" = {
          format = "<span foreground='#282828' background='#d3869b' font_family='Symbols Nerd Font Mono'>  󰣆  </span> {class}";
          separate-outputs = true;
          icon = false;
          tooltip = false;
        };

        tray = {
          icon-size = 14;
          spacing = 8;
        };

        clock = {
          format = "<span foreground='#282828' background='#8ec07c' font_family='Symbols Nerd Font Mono'>  󰃭  </span> {:%I:%M %p}";
          tooltip = false;
          interval = 1;
        };

        "custom/memory" = {
          exec = "${config.home.homeDirectory}/bin/memory_usage.sh";
          interval = 2;
          return-type = "json";
          format = "<span foreground='#282828' background='#ea6962' font_family='Symbols Nerd Font Mono'>  󰍛  </span> {}";
          tooltip = false;
        };

        battery = {
          interval = 1;
          states = { good = 99; warning = 30; critical = 20; };
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];

          format = "<span foreground='#282828' background='#689d6a' font_family='Symbols Nerd Font Mono'>  {icon}  </span> {capacity}%";
          format-full = "<span foreground='#282828' background='#689d6a' font_family='Symbols Nerd Font Mono'>  {icon}  </span> {capacity}%";
          format-warning = "<span foreground='#282828' background='#e78a4e' font_family='Symbols Nerd Font Mono'>  {icon}  </span> {capacity}%";
          format-critical = "<span foreground='#282828' background='#cc241d' font_family='Symbols Nerd Font Mono'>  {icon}  </span> {capacity}%!!";

          format-charging = "<span foreground='#282828' background='#689d6a' font_family='Symbols Nerd Font Mono'>  󰂅  </span> {capacity}%";
          format-charging-warning = "<span foreground='#282828' background='#e78a4e' font_family='Symbols Nerd Font Mono'>  󰢝  </span> {capacity}%";
          format-charging-critical = "<span foreground='#282828' background='#cc241d' font_family='Symbols Nerd Font Mono'>  󰢜  </span> {capacity}%";
          format-plugged = "<span foreground='#282828' background='#689d6a' font_family='Symbols Nerd Font Mono'>  󰂅  </span> {capacity}%";

          format-alt = "<span foreground='#282828' background='#689d6a' font_family='Symbols Nerd Font Mono'>  󱧥  </span> {time}";
          tooltip = false;
        };

        network = {
          interval = 2;
          format = "<span foreground='#282828' background='#e78a4e' font_family='Symbols Nerd Font Mono'>  {icon}  </span> {bandwidthDownBits}";
          format-wifi = "<span foreground='#282828' background='#e78a4e' font_family='Symbols Nerd Font Mono'>  {icon}  </span> {bandwidthDownBits}";
          format-ethernet = "<span foreground='#282828' background='#d3869b' font_family='Symbols Nerd Font Mono'>  󰈀  </span> {bandwidthDownBits}";
          format-icons = ["󰤫" "󰤟" "󰤢" "󰤥" "󰤨"];
          tooltip = false;
          states = { normal = 25; };
        };

        pulseaudio = {
          format = "<span foreground='#282828' background='#83a598' font_family='Symbols Nerd Font Mono'>  󰕾  </span> {volume}%";
          format-muted = "<span foreground='#282828' background='#ea6962' font_family='Symbols Nerd Font Mono'>  󰖁  </span> {volume}%";
          format-bluetooth = "<span foreground='#282828' background='#83a598' font_family='Symbols Nerd Font Mono'>  󰂰  </span> {volume}%";
          format-bluetooth-muted = "<span foreground='#282828' background='#ea6962' font_family='Symbols Nerd Font Mono'>  󰂲  </span> {volume}%";
          format-source = "{volume}% ";
          on-click = "pavucontrol";
          tooltip = false;
          max-volume = 130;
        };
      };
    };

    style = ''
      * {
        padding: 0;
        margin: 0;
        min-height: 0;
        border-radius: 2px;
        border: none;
        text-shadow: none;
        transition: none;
        box-shadow: none;
      }

      /* spacing between right-side modules */
      #window, #clock, #custom-memory, #pulseaudio, #battery, #network {
        margin-right: 6px;
      }

      window#waybar {
        color: rgb(255, 244, 210);
        background: none;
        font-family: "IosevkaTerm Nerd Font Propo", "Noto Sans", "Noto Sans Symbols 2";
        font-size: 16px;
        font-weight: 800;
      }

      #custom-rofi,
      #workspaces button,
      #workspaces button:hover,
      #workspaces button.visible,
      #workspaces button.visible:hover,
      #workspaces button.active,
      #workspaces button.active:hover,
      #workspaces button.urgent,
      #window,
      #tray,
      #custom-memory,
      #pulseaudio,
      #pulseaudio.muted,
      #battery,
      #battery.critical,
      #battery.warning,
      #network,
      #clock {
        color: rgb(34, 34, 34);
        background: rgba(34, 34, 34, 0.99);
        border: 2px solid rgba(34, 34, 34, 0.99);
        border-radius: 3px;
        padding: 0 10px;
      }

      #custom-rofi {
        background: rgb(131, 165, 152);
        color: rgb(34, 34, 34);
        padding: 0 12px;
      }

      #workspaces { margin: 0; }
      #workspaces button {
        color: rgb(255, 244, 210);
        padding: 0 8px;
        margin: 0 4px;
        min-width: 28px;
        border-radius: 3px;
      }
      #workspaces button:hover { background: rgb(211, 134, 155); }
      #workspaces button.visible,
      #workspaces button.visible:hover,
      #workspaces button.active,
      #workspaces button.active:hover { background: rgb(142, 192, 124); }
      #workspaces button.urgent { background: rgb(234, 105, 98); }

      /* accent text colors (outer text, not the chips) */
      #window { color: rgb(211, 134, 155); }
      #tray { padding: 0 12px; background: rgb(34, 34, 34); border-radius: 3px; }
      #custom-memory { color: rgba(234, 105, 98, 1); }
      #pulseaudio { color: rgb(131, 165, 152); }
      #pulseaudio.muted { color: rgb(234, 105, 98); }
      #battery { color: rgb(104, 157, 106); }
      #battery.critical { color: rgb(204, 36, 29); }
      #battery.warning { color: rgb(231, 138, 78); }
      #clock { color: rgb(142, 192, 124); }
      #network { color: rgba(231, 138, 78, 1); }
    '';
  };
}
