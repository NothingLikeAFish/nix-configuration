{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop-packages-foot = { pkgs, ... }: {
    environment.systemPackages = with self.packages.${pkgs.stdenv.hostPlatform.system}; [
      foot
    ];
  };

  flake.wrappers.foot = { wlib, pkgs, ... }: {
    imports = [ wlib.wrapperModules.foot ];
    env.FONTCONFIG_FILE = pkgs.makeFontsConf { # Add font dependencies
      fontDirectories = [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.gohufont
      ];
    };
    settings = {
      main = {
        font = "GohuFont 11 Nerd Font:size=12";
        resize-by-cells = false;
        resize-keep-grid = false;
        pad = "8x8 center";
      };
      colors-dark = {
        #alpha = 0.8;
        background = self.colours.base00;
        foreground = self.colours.base05;
        regular0 = self.colours.base00; # Black
        regular1 = self.colours.base08; # Red
        regular2 = self.colours.base0B; # Green
        regular3 = self.colours.base0A; # Yellow
        regular4 = self.colours.base0D; # Blue
        regular5 = self.colours.base0E; # Magenta
        regular6 = self.colours.base0C; # Cyan
        regular7 = self.colours.base05; # White
        bright0 = self.colours.base01;
        bright1 = self.colours.base08;
        bright2 = self.colours.base0B;
        bright3 = self.colours.base0A;
        bright4 = self.colours.base0D;
        bright5 = self.colours.base0E;
        bright6 = self.colours.base0C;
        bright7 = self.colours.base06;
      };
    };
  };
}
