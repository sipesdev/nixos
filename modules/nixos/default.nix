{ pkgs, config, lib, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NixOS garbage collection
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Install some default packages
  environment.systemPackages = with pkgs; [
    neovim
    dotnet-sdk
    base16-schemes
    neofetch
    wget
    git
    btop
    lshw
    cmatrix
    nixfmt
    ffmpeg
    mpv
    feh
    seahorse
    firefox
  ];

  # Thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Default services
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.gnome.gnome-keyring.enable = true;
  services.printing.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
