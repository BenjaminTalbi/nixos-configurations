{ kb_variant ? "", kb_options ? "", monitor_config ? "", ... }:
''
    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor=eDP-1,highres,auto,1.5
    monitor=DP-1,preferred,auto,auto
    monitor=HDMI-A-1,preferred,auto,auto
    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Autostart
    exec-once = hyprpaper & waybar & dunst 
    exec-once = /usr/lib/polkit-kde-authentication-agent-1
    exec = udiskie --appindicator -t

    # TODO: Add this only on laptop?
    xwayland {
      force_zero_scaling = true
    }

    # Environment
    env = GDK_SCALE,2
    env = XCURSOR_SIZE,48

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

    #    0 - Cursor movement will not change focus.
    #    1 - Cursor movement will always change focus to the window under the cursor.
    #    2 - Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
    #    3 - Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.
        follow_mouse = 1

        touchpad {
            natural_scroll = no
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        border_size = 3

        # GAPS ON
        gaps_in = 1
        gaps_out = 1

        # GAPS OFF
        # gaps_in = 0
        # gaps_out = 0

        #col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        # TODO Extract for theming
        col.active_border = rgb(f6c177) 
        col.inactive_border = rgb(524f67) 
        rgba(524f67ee)

        layout = master
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 0
    
        blur = yes
        blur_size = 6
        blur_passes = 1
        blur_new_optimizations = on

        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)

    }

    animations {
        enabled = no

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        # Example Beziers (and others you can't use): https://easings.net/#
        # animation = NAME, ONOFF, SPEED, CURVE, (STYLE)

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        bezier = ease-in-out, .42, 0, .58, 1
        bezier = ease-out-back, 0.55, 1.49, 0.64, 1
        bezier = ease-out-over, 1, -0.05, .2, 1.31
        bezier = ease-out, 0, 0, .58, 1
        bezier = ease-in, .58, 1, 0, 0

        animation = windows, 1, 4, ease-out, slide
        animation = windowsIn, 1, 4, ease-out, slide 
        animation = windowsOut, 1, 3, ease-out, slide
        animation = windowsMove, 1, 3, ease-in-out, slide
        animation = border, 1, 2, ease-in-out
        animation = workspaces, 1, 4, ease-out, slide
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = false
        orientation = left
        always_center_master = false
        no_gaps_when_only = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = off
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    device:epic mouse V1 {
        sensitivity = -0.5
    }

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    # Rules
    # windowrulev2 = opacity 0.8 0.8,class:^(kitty)$
    # JetBrains
    windowrulev2 = center,class:^jetbrains-,title:^$
    windowrulev2 = forceinput,class:^jetbrains-,title:^$
    windowrulev2 = workspace name:notes silent,class:^(obsidian)$
    windowrulev2 = float, title:^(Steam - News
    windowrulev2 = float, class:^(org.kde.polkit-kde-authentication-agent-1)$
    windowrulev2 = forceinput, class:^(org.kde.polkit-kde-authentication-agent-1)$
    windowrulev2 = opacity 0.8 0.8,class:^(wezterm)$

    binds {
        allow_workspace_cycles = true
    }

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    # Also, https://wiki.hyprland.org/Configuring/Dispatchers/
    bind = SUPER, Return, exec, wezterm
    bind = SUPER SHIFT, Return, exec, wezterm start -- nvim ~/.config/wezterm/wezterm.lua
    bind = SUPER CONTROL, Return, exec, wezterm start -- nvim ~/.config/hypr/
    bind = SUPER SHIFT, C, killactive
    bind = SUPER SHIFT, Q, exit, 
    bind = SUPER, T, togglefloating, 
    bind = SUPER, P, exec, killall wofi || wofi --show drun -l 

    bind = SUPER SHIFT, s, exec, grimblast copy area
    bind = SUPER CONTROL, s, exec, hyprpicker

    # Pass through
    bind = SUPER, Escape, pass, ^(discord)$


    # Movement
    bind = SUPER, left, movefocus, l
    bind = SUPER, right, movefocus, r
    bind = SUPER, up, movefocus, u
    bind = SUPER, down, movefocus, d

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
    bind = SUPER CONTROL, l, splitratio, -0.025
    bind = SUPER CONTROL, h, splitratio, +0.025
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
    bind = SUPER, n, workspace, name:notes
    bind = SUPER SHIFT, n, workspace, previous

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
''
