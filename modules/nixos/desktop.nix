{ lib, config, pkgs, inputs, ... }:

{
  # Install desktop packages
  environment.systemPackages = with pkgs; [
    wl-clipboard
    hyprpicker
    hypridle
    hyprpolkitagent
    adwaita-qt6
    adwaita-icon-theme
    waybar
    mako
    pavucontrol
    libnotify
    rofi-wayland
    networkmanagerapplet
    xdg-desktop-portal-gtk
  ];

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };  

  # Set environment variables
  environment.sessionVariables = rec {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ./wallpapers/desktop.jpg;
    cursor.name = "Adwaita";
    polarity = "dark";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };
  };

  # Services
  services.hypridle.enable = true;
  services.blueman.enable = true;
  
  # Portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
