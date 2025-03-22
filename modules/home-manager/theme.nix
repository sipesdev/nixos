{ pkgs, lib, config, inputs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Purple-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}