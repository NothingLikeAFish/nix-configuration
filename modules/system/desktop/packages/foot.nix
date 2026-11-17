{ inputs, self, ... }:

{
  flake.modules.nixos.packages-foot = { pkgs, ... }: {
    environment.systemPackages = with self.packages.${pkgs.stdenv.hostPlatform.system}; [
      foot
    ];
  };

  flake.wrappers.foot = { wlib, pkgs, ... }: {
    imports = [ wlib.wrapperModules.foot ];
    env.FONTCONFIG_FILE = pkgs.makeFontsConf { # Add font dependencies
      fontDirectories = [
        pkgs.nerd-fonts.jetbrains-mono
      ];
    };
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        resize-by-cells = false;
        resize-keep-grid = false;
        pad = "8x8 center";
      };
      colors-dark = {
        #alpha = 0.8;
        background = self.colours.bg0;
        foreground = self.colours.fg0;
        regular0 = self.colours.bg1;
        regular1 = self.colours.red;
        regular2 = self.colours.green;
        regular3 = self.colours.yellow;
        regular4 = self.colours.blue;
        regular5 = self.colours.magenta;
        regular6 = self.colours.cyan;
        regular7 = self.colours.fg0;
        bright0 = self.colours.fg1;
        bright1 = self.colours.red;
        bright2 = self.colours.green;
        bright3 = self.colours.yellow;
        bright4 = self.colours.blue;
        bright5 = self.colours.magenta;
        bright6 = self.colours.cyan;
        bright7 = self.colours.fg0;
      };
    };
  };
}
