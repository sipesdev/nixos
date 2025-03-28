{ pkgs, lib, config, inputs, ... }:

{
  # Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = "5";
        gaps_out = "5";
        border_size = "2";
        resize_on_border = "false";
        allow_tearing = "false";
        layout = "dwindle";
      };
      decoration = {
        rounding = "10";
        rounding_power = "2";
        active_opacity = "1.0";
        inactive_opacity = "0.8";

        shadow = { # Disable for laptop
          enabled = "true";
          range = "4";
          render_power = "3";
        };

        blur = { # Disable for laptop
          enabled = "true";
          size = "3";
          passes = "1";
          vibrancy = "0.1696";
        };
      };
      misc = {
        vfr = "true";
      };

      "$mod" = "SUPER";
      bind = [
        # Control
        "$mod, Q, killactive"
        "$mod, V, togglefloating"
        "$mod, W, fullscreen"
        "$mod, M, exit"
        "$mod, SPACE, exec, rofi -show drun"

        # Movement
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # Switch application to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        # Applications
        "$mod, B, exec, firefox"
        "$mod, T, exec, alacritty"
        "$mod, F, exec, thunar"
      ];
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
      # Laptop keys
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
      # Autostart
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "waybar & nm-applet --indicator & blueman-applet & mako & hypridle"
      ];

      # Fixes
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus, class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
