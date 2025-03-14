{ pkgs, config, lib, inputs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ''
      window#waybar {
        background-color: transparent;
        color: #ffffff;
        font-family: sans-serif;
        font-size: 16px;
        border: none;
        box-shadow: none;
        padding: 0 10px;
      }
    '';
    settings = [{
      height = 30;
      layer = "top";
      position = "top";
      modules-left = [ "clock" "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "tray" "battery" ];

      # Custom modules
      battery = {
        format = " {icon} {capacity}%";
        format-alt = " {icon}";
        format-charging = " 󰂄 {capacity}%";
        format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰁹" ];
        format-plugged = "  {capacity}%";
        states = {
          critical = 10;
          warning = 20;
        };
      };
      "hyprland/workspaces" = {
        format = "{name}";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "hyprland/window" = {
        max-length = 64;
        separate-outputs = true;
      };
      "clock" = {
        format-alt = "{:%m-%d-%Y}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          format = { today = "<span color='#fAfBfC'><b>{}</b></span>"; };
        };
      };
    }];
  };
}
