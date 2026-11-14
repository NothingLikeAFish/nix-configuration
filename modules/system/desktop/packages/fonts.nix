{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop-packages-fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
