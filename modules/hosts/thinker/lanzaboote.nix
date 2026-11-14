{ inputs, self, ... }:

{
  flake.modules.nixos.hosts-thinker-lanzaboote = { pkgs, lib, ... }: { # Secure boot
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    #environment.systemPackages = [ pkgs.sbctl ]; # For debugging Purposes

    boot.loader.systemd-boot.enable = false; # Currently lanzaboote replaces systemd-boot module

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };
    };
  };
}
