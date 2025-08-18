{ config, pkgs, root, lib, ... }:
{
  # QuickShell and audio control packages
  home.packages = with pkgs; [
    quickshell
    qt6.qt5compat
    # Audio controls
    pulseaudio
    wireplumber
    alsa-utils
  ];

  # Link your entire quickshell config from the flake
  home.file.".config/quickshell" = {
    source = root + "/dots/quickshell";
    recursive = true;
  };

  # Append to exec-once without self-referencing
  wayland.windowManager.hyprland.settings.exec-once = lib.mkAfter [
    "quickshell"
  ];
}
