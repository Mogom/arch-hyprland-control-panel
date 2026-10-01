# Arch Hyprland Control Panel

Este repositorio contiene una base para un panel de control flotante tipo "Control Center" para Hyprland, con paleta Tokyo Night y estilo muy limpio, pensado para combinar con tu SDDM y tu wallpaper de anime.

## Estructura

- `.config/eww/eww.yuck` — layout del widget
- `.config/eww/eww.scss` — estilos visuales
- `.config/eww/scripts/control-panel.sh` — helpers para volumen, brillo, Wi‑Fi y toggles
- `README.md` — instrucciones de uso

## Instalación rápida

1. Instala `eww`:

```bash
yay -S eww
```

2. Copia esta configuración:

```bash
mkdir -p ~/.config
cp -r .config/eww ~/.config/
```

3. Asegúrate de que `control-panel.sh` tenga permisos ejecutables:

```bash
chmod +x ~/.config/eww/scripts/control-panel.sh
```

4. Abre el panel desde terminal:

```bash
eww open control-panel
```

5. Cierra el panel:

```bash
eww close control-panel
```

## Integración con Hyprland

Añade estos binds a tu `~/.config/hypr/hyprland.conf`:

```conf
bind = SUPER, SPACE, exec, ~/.config/eww/scripts/control-panel.sh toggle
bind = SUPER SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
```

## Personalización

- Cambia la paleta Tokio Night dentro de `.config/eww/eww.scss`
- Ajusta medidas, radio, ancho y posición del panel a tu gusto
- Añade más módulos según necesites: redes, bluetooth, temperatura, música, etc.

## Nota

Este panel está pensado para ser una base visual y funcional. Puedes ampliarlo fácilmente para que se sienta más parecido a tu idea original, con menos UI, más compacto y con un look aún más anime estilo texto + cristal + neon.
