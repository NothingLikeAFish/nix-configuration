{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      fastfetch
      librewolf
      zed-editor
    ];
  };
}
