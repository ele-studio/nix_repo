{ config, pkgs, ... }:

{
  # Enable COSMIC Desktop and Greeter
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  # Ensure D-Bus and Portals are ready
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Audio (shared with other DEs)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  security.rtkit.enable = true;

  # Add COSMIC apps
  environment.systemPackages = with pkgs; [
    cosmic-comp
    cosmic-bg
    cosmic-edit
    cosmic-files
    cosmic-launcher
    cosmic-notifications
    cosmic-osd
    cosmic-panel
    cosmic-settings
  ];
}
