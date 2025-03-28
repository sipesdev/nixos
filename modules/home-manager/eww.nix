{ config, lib, pkgs, ... }:

let
  cfg = config.programs.eww-material-bar;
in

{
  # Define module options
  options.programs.eww-material-bar = {
    enable = lib.mkEnableOption "Eww bar with Material theme";
  };

  # Configuration applied when the module is enabled
  config = lib.mkIf cfg.enable {
    programs.eww = {
      enable = true;
      package = pkgs.eww-wayland; # Install Eww with Wayland support for Hyprland
      configDir = pkgs.runCommand "eww-config" {} ''
        mkdir -p $out

        # Write eww.yuck configuration file
        cat > $out/eww.yuck <<EOF
(defwindow bar
  :monitor 0
  :geometry (geometry :x "0%"
              :y "0%"
              :width "100%"
              :height "40px"
              :anchor "top center")
  :stacking "fg"
  :exclusive true
  (box :class "bar" :orientation "h" :space-evenly false
    (box :class "left" :halign "start" :space-evenly false
      (label :text "Apps" :class "launcher"))
    (box :class "center" :halign "center"
      (label :text "\${time}" :class "clock"))
    (box :class "right" :halign "end" :space-evenly true
      (label :text "\${battery}%" :class "battery")
      (label :text "\${wifi}" :class "wifi"))))

(defpoll time :interval "1s" `date +"%H:%M"`)
(defpoll battery :interval "60s" `cat /sys/class/power_supply/BAT0/capacity`)
(defpoll wifi :interval "10s" `iwctl station wlan0 show | grep "Connected network" | awk '{print \$3}' || echo "No WiFi"`)
EOF

        # Write eww.css configuration file
        cat > $out/eww.css <<EOF
/* Global variables for Material theme */
:root {
  --primary-color: #1E88E5; /* Android 14 blue accent */
  --background: #212121;    /* Dark gray from Material Design */
  --surface: #2C2C2C;       /* Slightly lighter for elevation */
  --text-color: #FFFFFF;    /* White text for contrast */
  --shadow: 0 2px 4px rgba(0, 0, 0, 0.3); /* Subtle elevation */
}

/* Bar styling */
.bar {
  background-color: var(--background);
  padding: 4px 10px;
  box-shadow: var(--shadow);
}

/* Launcher (left) */
.launcher {
  color: var(--text-color);
  font-family: "Roboto", sans-serif; /* Material Design font */
  font-size: 14px;
  padding: 6px 12px;
  background-color: var(--surface);
  border-radius: 20px; /* Rounded like ChromeOS buttons */
  margin-left: 10px;
}

/* Clock (center) */
.clock {
  color: var(--text-color);
  font-family: "Roboto", sans-serif;
  font-size: 16px;
  font-weight: 500;
}

/* System tray (right) */
.battery, .wifi {
  color: var(--text-color);
  font-family: "Roboto", sans-serif;
  font-size: 14px;
  padding: 6px 12px;
  background-color: var(--surface);
  border-radius: 20px; /* Rounded Material style */
  margin-right: 10px;
}

/* Hover effects for interactivity */
.launcher:hover, .battery:hover, .wifi:hover {
  background-color: var(--primary-color);
  transition: background-color 0.2s ease; /* Smooth Material transition */
}
EOF
      '';
    };
  };
}