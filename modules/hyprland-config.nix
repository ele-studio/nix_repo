{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1,3440x1440@60,0x0,1"
      "eDP-1,2256x1504@60,3440x0,1.175"
      ",preferred,auto,auto"
    ];

    workspace = [
      "1, monitor:eDP-1, default:true"
      "2, monitor:eDP-1"
      "3, monitor:eDP-1"
      "4, monitor:eDP-1"
      "5 "
      "6 "
      "7 "
      "8 "
    ];

    exec-once = [
      "waybar"
      "ghostty"
      "hyprctl dispatch workspace 1"
    ];

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      mouse_refocus = false;
      kb_options = caps:super;
    };


    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(e78a4eff)";
      "col.inactive_border" = "rgba(d8a657ff)";
    };

    decoration.rounding = 5;

    animations.enabled = true;

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_focuses_monitor = true;
    };

    bind = [
      # Power Options
      "SUPER SHIFT, Q, exec, systemctl poweroff"
      "SUPER SHIFT, P, exec, ${config.home.homeDirectory}/bin/power.sh"
      "SUPER, L, exec, hyprlock"

      # App Launchers
      "SUPER, RETURN, exec, ghostty"
      "SUPER, Q, killactive,"
      "SUPER, M, exit,"
      "SUPER, E, exec, nautilus"
      "SUPER, V, togglefloating,"
      "SUPER, F, exec, firefox"
      "SUPER, D, exec, rofi -show drun"
      "SUPER, SPACE, exec, wofi --show drun"
      "SUPER, P, exec, hyprshot -m region"
      "SUPER, A, exec, firefox --new-window https://chatgpt.com"
      "SUPER, N, exec, ghostty -e nvim"
      "SUPER, K, exec, ${config.home.homeDirectory}/bin/keybinding.sh"

      # Focus movement
      "SUPER, H, movefocus, l"

      # Swap windows with arrows
      "SUPER SHIFT, H, movewindow, l"
      "SUPER SHIFT, L, movewindow, r"
      "SUPER SHIFT, J, movewindow, d"
      "SUPER SHIFT, K, movewindow, u"

      # Workspaces
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER CTRL, right, workspace, e+1"
      "SUPER CTRL, left, workspace, e-1"

      # Move to workspace
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"

      # Monitor toggle: move focused window to the next/prev monitor
      "SUPER SHIFT, up,   movewindow, mon:+1"
      # (optional) go the other way:
      "SUPER SHIFT, down, movewindow, mon:-1"


      # Window tiling / split behavior
      "SUPER, J, togglesplit,"

      # Resize windows
      "SUPER, right, resizeactive, 20 0"
      "SUPER, left, resizeactive, -20 0"
      "SUPER, up, resizeactive, 0 -20"
      "SUPER, down, resizeactive, 0 20"

      # Workspace scroll
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"

      # Monitor switching
      "SUPER, TAB, focusmonitor, +1"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
