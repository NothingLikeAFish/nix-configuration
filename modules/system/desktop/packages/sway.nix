{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop-packages-sway = {
    programs.sway.enable = true;
  };
};
