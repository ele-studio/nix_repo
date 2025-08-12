{ config, pkgs, root, ... }:

{
  programs.neovim.enable = true;

  home.file.".config/nvim" = {
    source = root + "/dots/nvim";
    recursive = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    python3
    wl-clipboard
    xclip
    nodejs_22
    git
    curl
    unzip
    gcc
  ];
}
