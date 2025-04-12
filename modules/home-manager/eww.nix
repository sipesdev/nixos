{ pkgs, config, lib, inputs, ... }:

let
  # Define reusable color variables (Catppuccin Mocha palette)
  colors = {
    bg = "#1e1e2e"; # Mocha Base
    fg = "#cdd6f4"; # Mocha Text
    bg-alt = "#313244"; # Mocha Surface1
    primary = "#89b4fa"; # Mocha Blue
    secondary = "#f5c2e7"; # Mocha Pink
    urgent = "#f38ba8"; # Mocha Red
    wks-bg = "#45475a"; # Mocha Surface2
    wks-active = colors.primary;
    wks-occupied = colors.secondary;
    wks-empty = colors.wks-bg;
    wks-urgent = colors.urgent;
    wks-hover = "#585b70"; # Mocha Overlay0
  };

  # --- Embedded Eww Yuck Content ---
  ewwYuckContent = ''
    ;; Eww Configuration - eww.yuck
    ;; Inspired by Gnome / Android top bar

    ;; --- Variables ---
    (defpoll clock_time :interval "10s" "date '+%H:%M'")
    (defpoll clock_date :interval "1m" "date '+%a %d %b'") ; Day Date Month

    (defpoll volume_percent :interval "1s" "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'")
    (defpoll volume_muted :interval "1s" "wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 'true' || echo 'false'")

    (defpoll battery_capacity :interval "30s" "cat /sys/class/power_supply/BAT0/capacity || echo '?'") ; Adjust BAT0 if needed
    (defpoll battery_status :interval "30s" "cat /sys/class/power_supply/BAT0/status || echo '?'") ; Adjust BAT0 if needed

    (defpoll network_ssid :interval "10s" "nmcli -t -f NAME connection show --active | head -n 1 || echo 'Disconnected'")
    (defpoll network_icon :interval "10s" :initial "󰤮" ; Nerd Font: nf-md-wifi_off
      "if nmcli -t -f STATE general | grep -q 'connected'; then
         echo '󰤨'; ; Nerd Font: nf-md-wifi
       else
         echo '󰤮'; ; Nerd Font: nf-md-wifi_off
       fi")

    ;; --- Widgets ---
    ; Workspace Button
    (defwidget ws-button [ws]
      (eventbox :onclick "echo 'Switch workspace to ${ws.id}'"
        (box :class "ws-button ${ws.id == current_workspace ? 'active' : ''} ${ws.windows > 0 ? 'occupied' : 'empty'} ${ws.urgent ? 'urgent' : ''}"
             :tooltip "Workspace ${ws.name}"
          "${ws.icon}"
        )
      )
    )

    ; Workspaces Module
    (defwidget workspaces_widget []
      (box :class "workspaces" :orientation "h" :space-evenly false :halign "start" :spacing 5
        (for ws in workspaces
          (ws-button :ws ws)
        )
      )
    )

    ; Clock Module
    (defwidget clock_widget []
      (box :class "clock-module" :orientation "h" :space-evenly false :halign "center" :spacing 6
        (label :text clock_time :class "clock-time")
        (label :text clock_date :class "clock-date")
      )
    )

    ; Volume Module
    (defwidget volume_widget []
      (eventbox :onclick "pavucontrol &"
        (box :class "volume-module" :orientation "h" :space-evenly false :halign "end" :spacing 6
             :tooltip "Volume: ${volume_percent}% ${volume_muted == 'true' ? '(Muted)' : ''}"
          (label :text {volume_muted == "true" ? "󰖁" : "󰕾"} :class "icon")
          (label :text "${volume_percent}%")
        )
      )
    )

    ; Battery Module
    (defwidget battery_widget []
      (box :class "battery-module ${battery_status == 'Charging' ? 'charging' : ''} ${battery_status == 'Discharging' && battery_capacity < 20 ? 'low' : ''}"
           :orientation "h" :space-evenly false :halign "end" :spacing 6
           :tooltip "${battery_status} ${battery_capacity}%"
        (label :text {battery_status == 'Charging' ? '󰂄' : (battery_capacity > 90 ? '󰁹' : battery_capacity > 70 ? '󰂁' : battery_capacity > 50 ? '󰁾' : battery_capacity > 30 ? '󰁼' : battery_capacity > 10 ? '󰁺' : '󰂎')} :class "icon")
        (label :text "${battery_capacity}%")
      )
    )

    ; Network Module
    (defwidget network_widget []
      (eventbox :onclick "nm-applet &"
        (box :class "network-module" :orientation "h" :space-evenly false :halign "end" :spacing 6
             :tooltip "${network_ssid}"
          (label :text network_icon :class "icon")
          (label :text {network_ssid == "Disconnected" ? "" : network_ssid} :class "network-ssid")
        )
      )
    )

    ; --- Bar Layout ---
    (defwidget left_widgets []
      (box :class "left-widgets" :orientation "h" :space-evenly false :halign "start" :spacing 10
        (workspaces_widget)
      )
    )

    (defwidget center_widgets []
      (box :class "center-widgets" :orientation "h" :space-evenly false :halign "center" :spacing 10
        (clock_widget)
      )
    )

    (defwidget right_widgets []
      (box :class "right-widgets" :orientation "h" :space-evenly false :halign "end" :spacing 15
        (network_widget)
        (volume_widget)
        (battery_widget)
      )
    )

    ; --- Window Definition ---
    (defwindow bar
      :monitor 0
      :windowtype "dock"
      :geometry (geometry :x "0%" :y "5px" :width "98%" :height "28px" :anchor "top center")
      :reserve (struts :side "top" :distance "38px")
      :stacking "fg"
      :exclusive true
      :focusable false

      (centerbox :orientation "h" :class "main-bar"
        (left_widgets)
        (center_widgets)
        (right_widgets)
      )
    )
  ''; # End of ewwYuckContent

  # --- Embedded Eww Scss Content ---
  ewwScssContent = ''
    /* Eww Stylesheet - eww.scss */
    $bg: ${colors.bg};
    $fg: ${colors.fg};
    $bg-alt: ${colors.bg-alt};
    $primary: ${colors.primary};
    $secondary: ${colors.secondary};
    $urgent: ${colors.urgent};
    $wks-bg: ${colors.wks-bg};
    $wks-active: ${colors.wks-active};
    $wks-occupied: ${colors.wks-occupied};
    $wks-empty: ${colors.wks-empty};
    $wks-urgent: ${colors.wks-urgent};
    $wks-hover: ${colors.wks-hover};

    /* Global styles */
    * {
      all: unset;
      font-family: "JetBrainsMono Nerd Font", sans-serif;
      font-size: 10pt;
      color: $fg;
    }

    .main-bar {
      background-color: rgba(30, 30, 46, 0.85);
      border-radius: 12px;
      padding: 0px 12px;
      margin: 5px 0px;
      border: 1px solid rgba(49, 50, 68, 0.8);
    }

    .ws-button {
      background-color: $wks-bg;
      &:hover {
        background-color: $wks-hover;
      }
    }

    .clock-time {
      font-weight: bold;
    }

    .battery-module .icon {
      color: $primary;
    }
  ''; # End of ewwScssContent

in {
  programs.eww = {
    enable = true;

    # Configure Eww Files using xdg.configFile and embedded text
    xdg.configFile = {
      "eww/eww.yuck" = {
        text = ewwYuckContent;
      };
      "eww/eww.scss" = {
        text = ewwScssContent;
      };
    };
  };
}