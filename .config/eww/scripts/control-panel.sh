#!/usr/bin/env bash

EWw_DIR="$HOME/.config/eww"

case "$1" in
  toggle)
    if eww active-windows | grep -q "control-panel"; then
      eww close control-panel
    else
      eww open control-panel
    fi
    ;;

  get-volume)
    wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2 * 100)}' || echo 0
    ;;

  volume-up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    ;;

  volume-down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;

  volume-toggle)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;

  get-brightness)
    brightnessctl -m 2>/dev/null | awk -F',' 'NR==1 {print $4}' | tr -d '%' || echo 0
    ;;

  brightness-up)
    brightnessctl set 5%+
    ;;

  brightness-down)
    brightnessctl set 5%-
    ;;

  get-battery)
    for bat in /sys/class/power_supply/BAT*; do
      if [ -f "$bat/capacity" ]; then
        cat "$bat/capacity"
        exit 0
      fi
    done
    echo 0
    ;;

  get-wifi)
    nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | awk '$1=="yes" {print $2; exit}' | head -n 1 || echo "Wi‑Fi"
    ;;

  get-cpu)
    mpstat 1 1 2>/dev/null | awk '$3 ~ /CPU/ {for (i=1;i<=NF;i++) if ($i=="%idle") {idle_col=i; break}} $3 ~ /all/ {print 100 - $NF}' | tail -n1 || echo 0
    ;;

  get-ram)
    free | awk '/^Mem:/ {printf "%d", ($3/$2) * 100}' || echo 0
    ;;

  lock)
    loginctl lock-session || hyprlock
    ;;

  logout)
    hyprctl dispatch exit
    ;;

  reboot)
    systemctl reboot
    ;;

  shutdown)
    systemctl poweroff
    ;;

  *)
    echo "Uso: $0 [toggle|get-volume|volume-up|volume-down|volume-toggle|get-brightness|brightness-up|brightness-down|get-battery|get-wifi|get-cpu|get-ram|lock|logout|reboot|shutdown]"
    exit 1
    ;;
esac
