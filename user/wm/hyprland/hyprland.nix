{ inputs, config, lib, pkgs, userSettings, systemSettings, ... }:

{
  imports = [
    ../../app/terminal/foot.nix
    ../../hardware/bluetooth.nix
  ];

  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = if (config.stylix.polarity == "light") then "Quintom_Ink" else "Quintom_Snow";
    size = 36;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = { };
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      # Monitors
      monitor=DP-1,preferred,auto,auto

      # Autostart
      exec-once = dbus-update-activation-enviroment DISPLAY XAUTHORITY WAYLAND_DISPLAY
      exec-once = hyprctl setcursor ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}
      exec-once = nm-applet
      exec-once = blueman-applet
      exec-once = waybar
      exec-once = hypridle
      exec-once = hyprdim -d 450 -s 0.25 -D 0.25 -p
      
      env = QT_QPA_PLATFORMTHEME,qt5ct

      general {
        layout = master
        resize_on_border = true
        border_size = 4
        gaps_in = 7
        gaps_out = 7

        col.active_border = 0xff${config.lib.stylix.colors.base08}
        col.inactive_border = 0x33${config.lib.stylix.colors.base00}
      }

      master {
        new_is_master = false
      }

      xwayland {
        force_zero_scaling = true;
      }

      input {
        kb_layout = us
        kb_options = compose:menu
        # 0 - Cursor movement will not change focus.
        # 1 - Cursor movement will always change focus to the window under the cursor.
        # 2 - Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
        # 3 - Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.
        follow_mouse = 2
        touchpad {
          natural_scroll = no
        }
      }
      
      binds {
        workspace_back_and_forth = true
        workspace_center_on = true
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true

      }

      cursor {
        hide_on_key_press = true
      }
      
      decoration {
        rounding = 3
        drop_shadow = true
        
        blur { 
          enabled = true
          size = 5 
          passes = 2 
          ignore_opacity = true
          xray = true
        }
      }
      
      animations {
        enabled = true
        # TODO when in VM
      }

      # Core
      bind = SUPER, Return, exec, ${userSettings.term} 
      bind = SUPER SHIFT, C, killactive
      bind = SUPER CONTROL SHIFT, Q, exit, 
      bind = SUPER, T, togglefloating, 
      # TODO Fuzzle?
      bind = SUPER, P, exec, killall wofi || wofi --normal-window --show drun
      bind = SUPER CONTROL, s, exec, hyprpicker

      bind = SUPER SHIFT, s, exec, systemctl suspend
      bindl =,switch:on:Lid Switch, exec, loginctl lock-session
      bind = SUPER CTRL, L, exec, loginctl lock-session
      
      # Media Keys
      bindle =, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
      bindle =, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
      bindl  =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle 
      bindle =, XF86MonBrightnessUp, exec, brightnessctl set +1% 
      bindle =, XF86MonBrightnessDown, exec,brightnessctl set 1%-
      bindl  =, XF86AudioPlay, exec, playerctl play-pause 
      bindl  =, XF86AudioNext, exec, playerctl next 
      bindl  =, XF86AudioPrev, exec, playerctl previous
      # TODO Fuzzle?
      bindle =, XF86Search, exec, SUPER, P, exec, killall wofi || wofi --show drun -l

      # Movement
      bind = SUPER, j, layoutmsg, cyclenext
      bind = SUPER, k, layoutmsg, cycleprev

      bind = SUPER CONTROL, j, layoutmsg, orientationnext
      bind = SUPER CONTROL, k, layoutmsg, orientationprev

      bind = SUPER SHIFT, j, layoutmsg, swapnext
      bind = SUPER SHIFT, k, layoutmsg, swapprev
      
      bind = SUPER, space, layoutmsg, focusmaster
      bind = SUPER SHIFT, space, layoutmsg, swapwithmaster
    
      bind = SUPER, m, layoutmsg, addmaster
      bind = SUPER SHIFT, m, layoutmsg, removemaster

      bind = SUPER, i, fullscreen, 0
      bind = SUPER SHIFT, i, fakefullscreen 

      # Resize window
      bind = SUPER, l, splitratio, -0.05
      bind = SUPER, h, splitratio, +0.05

      bind = SUPER SHIFT, l, splitratio, -0.10
      bind = SUPER SHIFT, h, splitratio, +0.10

      # Switch workspaces with mainMod + [0-9]
      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = SUPER SHIFT, 1, movetoworkspace, 1
      bind = SUPER SHIFT, 2, movetoworkspace, 2
      bind = SUPER SHIFT, 3, movetoworkspace, 3
      bind = SUPER SHIFT, 4, movetoworkspace, 4
      bind = SUPER SHIFT, 5, movetoworkspace, 5
      bind = SUPER SHIFT, 6, movetoworkspace, 6
      bind = SUPER SHIFT, 7, movetoworkspace, 7
      bind = SUPER SHIFT, 8, movetoworkspace, 8
      bind = SUPER SHIFT, 9, movetoworkspace, 9
      bind = SUPER SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow
    '';
  };

  home.packages = with pkgs; [
    feh
    killall
    wl-clipboard
    hyprland-protocols
    hyprpicker
    hypridle
    hyprlock
    hyprdim
    swaybg
    fuzzel
    wev
    grim
    slurp
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    pavucontrol
    pamixer
  ];

  home.file.".config/hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pgrep hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      ignore_dbus_inhibit = false
    }

    listener {
      timeout = 300 # in seconds
      on-timeout = loginctl lock-session
    }
    listener {
      timeout = 600 # in seconds
      on-timeout = systemctl suspend
    }
  '';

  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = screenshot

      # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
      blur_passes = 4
      blur_size = 5
      noise = 0.0117
      contrast = 0.8916
      brightness = 0.8172
      vibrancy = 0.1696
      vibrancy_darkness = 0.0
    }

    # doesn't work yet
    image {
      monitor =
      path = /home/emmet/.dotfiles/user/wm/hyprland/nix-dark.png
      size = 150 # lesser side if not 1:1 ratio
      rounding = -1 # negative values mean circle
      border_size = 0
      rotate = 0 # degrees, counter-clockwise

      position = 0, 200
      halign = center
      valign = center
    }

    input-field {
      monitor =
      size = 200, 50
      outline_thickness = 3
      dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = false
      dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
      outer_color = rgb(${config.lib.stylix.colors.base07-rgb-r},${config.lib.stylix.colors.base07-rgb-g},${config.lib.stylix.colors.base07-rgb-b})
      inner_color = rgb(${config.lib.stylix.colors.base00-rgb-r},${config.lib.stylix.colors.base00-rgb-g}, ${config.lib.stylix.colors.base00-rgb-b})
      font_color = rgb(${config.lib.stylix.colors.base07-rgb-r},${config.lib.stylix.colors.base07-rgb-g}, ${config.lib.stylix.colors.base07-rgb-b})
      fade_on_empty = true
      fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
      placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
      hide_input = false
      rounding = -1 # -1 means complete rounding (circle/oval)
      check_color = rgb(${config.lib.stylix.colors.base0A-rgb-r},${config.lib.stylix.colors.base0A-rgb-g}, ${config.lib.stylix.colors.base0A-rgb-b})
      fail_color = rgb(${config.lib.stylix.colors.base08-rgb-r},${config.lib.stylix.colors.base08-rgb-g}, ${config.lib.stylix.colors.base08-rgb-b})
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
      fail_transition = 300 # transition time in ms between normal outer_color and fail_color
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
      invert_numlock = false # change color if numlock is off
      swap_font_color = false # see below

      position = 0, -20
      halign = center
      valign = center
    }

    label {
      monitor =
      text = Moin moin, ${userSettings.name} 
      color = rgb(${config.lib.stylix.colors.base07-rgb-r},${config.lib.stylix.colors.base07-rgb-g}, ${config.lib.stylix.colors.base07-rgb-b})
      font_size = 25
      font_family = ${systemSettings.font.regular.name} 
      rotate = 0 # degrees, counter-clockwise

      position = 0, 160
      halign = center
      valign = center
    }

    label {
      monitor =
      text = $TIME
      color = rgb(${config.lib.stylix.colors.base07-rgb-r},${config.lib.stylix.colors.base07-rgb-g}, ${config.lib.stylix.colors.base07-rgb-b})
      font_size = 20
      font_family = ${systemSettings.font.regular.name} 
      rotate = 0 # degrees, counter-clockwise

      position = 0, 80
      halign = center
      valign = center
    }
  '';

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      postPatch = ''
        # TODO unsure what this does https://github.com/librephoenix/nixos-config/blob/5dcc42987580a56a979a124c372156c45a33e504/user/wm/hyprland/hyprland.nix#L531
        # use hyprctl to switch workspaces
        sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch focusworkspaceoncurrentmonitor " + std::to_string(id());\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        sed -i 's/gIPC->getSocket1Reply("dispatch workspace " + std::to_string(id()));/gIPC->getSocket1Reply("dispatch focusworkspaceoncurrentmonitor " + std::to_string(id()));/g' src/modules/hyprland/workspaces.cpp
      '';
    });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "7 7 3 7";
        spacing = 2;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "idle_inhibitor" "tray" ];

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        # TODO Add rest... https://github.com/librephoenix/nixos-config/blob/5dcc42987580a56a979a124c372156c45a33e504/user/wm/hyprland/hyprland.nix#L617
      };
    };
  };

  services.udiskie = {
    enable = true;
    tray = true;
  };
  
  # TODO Program launcher
  # TODO Notification Deamon
} 
