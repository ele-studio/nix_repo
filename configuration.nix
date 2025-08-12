{ config, pkgs, inputs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "Sn0wyRiver";
  networking.networkmanager.enable = true;

  # Localization
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Display and Desktop Environment
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # System services
  services.dbus.enable = true;
  services.fwupd.enable = true;
  services.flatpak.enable = true;
  services.printing.enable = false;
  services.openssh.enable = true;
  services.fprintd.enable = false;

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde pkgs.xdg-desktop-portal-hyprland ];
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User configuration
  users.users.wesley = {
    isNormalUser = true;
    description = "Wesley";
    extraGroups = [ "networkmanager" "wheel" "bluetooth" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.konsole
      dconf-editor
    ];
    shell = pkgs.fish;
  };

  # Fonts
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # Default shell
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  # Programs
  programs.firefox.enable = true;
  programs.ssh.startAgent = true;

  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # PAM config for Hyprlock
  security.pam.services.hyprlock = {
    allowNullPassword = false;
  };

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      user.name = "Wesley";
      user.email = "tech@ele.studio";
      init.defaultBranch = "main";
    };
  };

  # Fish shell configuration
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#nixos";
      update = "nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      g = "git";
      lg = "lazygit";
      housekeeper = "sudo nix-collect-garbage --delete-older-than 30d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    btop
    eog
    fish
    fishPlugins.done
    fishPlugins.fzf-fish
    fzf
    gcc
    ghostty
    git
    gnome-disk-utility
    lazygit
    localsend
    nautilus
    neovim
    nodejs_22
    overskride
    papirus-icon-theme
    pavucontrol
    quickemu
    tailscale
    typora
    vim
    vlc
    vscode
    quickshell
    wget
    libappindicator
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
  ];

  # Firewall
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

  # System version
  system.stateVersion = "25.05";
}
