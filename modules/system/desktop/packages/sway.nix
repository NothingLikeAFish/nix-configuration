{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop-packages-sway = { pkgs, ... }: {
    programs.sway = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.swayfx;
    };
  };

  flake.wrappers.swayfx = { pkgs, lib, wlib, config, ... }: {
    imports = [ wlib.modules.default ];
    package = pkgs.swayfx;
    passthru.providedSessions = pkgs.swayfx.passthru.providedSessions;
    env.XCURSOR_PATH = "${pkgs.adwaita-icon-theme}/share/icons";
    env.FONTCONFIG_FILE = pkgs.makeFontsConf { # Add font dependencies
      fontDirectories = [
        pkgs.nerd-fonts.jetbrains-mono
      ];
    };
    flags."-c" = config.constructFiles.config.path;
    constructFiles.config = {
      relPath = "config";
      content = ''
        exec ${lib.getExe pkgs.autotiling}

        font pango:JetBrainsMono Nerd Font Bold 12

        # WALLPAPER
        output * bg ${self.wallpaper} fill

        seat * xcursor_theme Adwaita 24

        # CLAMSHELL
        bindswitch --reload --locked lid:on output eDP-1 disable
        bindswitch --reload --locked lid:off output eDP-1 enable

        # INPUTS
        input type:touchpad {
          natural_scroll enabled
          dwtp enabled
        }
        input type:trackpoint {
          dwt enabled
        }

        #mouse_warping container

        # KEYBINDS
        set $mod Mod4
        floating_modifier $mod
        bindsym $mod+Shift+c reload
        bindsym $mod+q kill
        bindsym $mod+f fullscreen
        bindsym $mod+Shift+Space floating toggle

        #bindsym $mod+Return exec ${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.foot}
        bindsym $mod+Space exec ${lib.getExe pkgs.fuzzel}

        bindsym XF86MonBrightnessUp exec ${lib.getExe pkgs.brightnessctl} s +5%
        bindsym XF86MonBrightnessDown exec ${lib.getExe pkgs.brightnessctl} s 5%-
        bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_SINK@ 5%+
        bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_SINK@ 5%-
        bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_SINK@ toggle

        bindsym $mod+Left focus left
        bindsym $mod+Right focus right
        bindsym $mod+Up focus up
        bindsym $mod+Down focus down
        bindsym $mod+Shift+Left move left
        bindsym $mod+Shift+Right move right
        bindsym $mod+Shift+Up move up
        bindsym $mod+Shift+Down move down

        bindsym $mod+1 workspace number 1
        bindsym $mod+2 workspace number 2
        bindsym $mod+3 workspace number 3
        bindsym $mod+4 workspace number 4
        bindsym $mod+5 workspace number 5
        bindsym $mod+6 workspace number 6
        bindsym $mod+7 workspace number 7
        bindsym $mod+8 workspace number 8
        bindsym $mod+9 workspace number 9
        bindsym $mod+0 workspace number 10
        bindsym $mod+Shift+1 move container to workspace 1
        bindsym $mod+Shift+2 move container to workspace 2
        bindsym $mod+Shift+3 move container to workspace 3
        bindsym $mod+Shift+4 move container to workspace 4
        bindsym $mod+Shift+5 move container to workspace 5
        bindsym $mod+Shift+6 move container to workspace 6
        bindsym $mod+Shift+7 move container to workspace 7
        bindsym $mod+Shift+8 move container to workspace 8
        bindsym $mod+Shift+9 move container to workspace 9
        bindsym $mod+Shift+0 move container to workspace 10

        bindsym $mod+Shift+e exec swaynag -t warning -m 'Do you want to exit sway?' -B 'Exit sway' 'swaymsg exit' -f 'JetBrainsMono Nerd Font'

        # AESTHETICS
        default_border none
        default_floating_border none
        gaps inner 8

        client.focused #${self.colours.base02} #${self.colours.base00} #${self.colours.base05} #${self.colours.base02} #${self.colours.base02}
        client.focused_inactive #${self.colours.base01} #${self.colours.base00} #${self.colours.base05} #${self.colours.base01} #${self.colours.base01}
        client.unfocused #${self.colours.base01} #${self.colours.base00} #${self.colours.base05} #${self.colours.base01} #${self.colours.base01}
        client.placeholder #${self.colours.base01} #${self.colours.base00} #${self.colours.base05} #${self.colours.base01} #${self.colours.base01}
        client.urgent #${self.colours.base08} #${self.colours.base00} #${self.colours.base08} #${self.colours.base08} #${self.colours.base08}

        bar {
          position top
          height 32
          workspace_min_width 32
          gaps 0 320
          font pango:JetBrainsMono Nerd Font Bold 12
          status_edge_padding 0
          status_padding 0
          tray_output none
        }
      '';
    };
  };
}
