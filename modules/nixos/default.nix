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
    dotnet-sdk_9
    base16-schemes
    neofetch
    wget
    git
    htop
    nvtopPackages.full
    lshw
    cmatrix
    nixfmt
    ffmpeg
    mpv
    feh
    seahorse
    firefox
    bitwarden-desktop
    rquickshare
    slack
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

  # Firewall
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # Disable wake from PCIE
  services.udev.extraRules = ''
  ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
  '';
}
