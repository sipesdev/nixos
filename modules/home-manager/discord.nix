{ pkgs, lib, config, inputs, ... }:

{
  programs.nixcord = {
    enable = true;  # enable Nixcord. Also installs discord package
    config = {
      useQuickCss = false;
      themeLinks = [        # or use an online theme
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
      ];
      frameless = true; # set some Vencord options
      plugins = {
        # Vencord plugins
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
}