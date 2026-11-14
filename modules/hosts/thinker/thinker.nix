{ inputs, self, ... }:

{
  flake.nixosConfigurations.thinker = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x13-amd
      ./_hardware-configuration.nix #nixos-generate-config --no-filesystems --dir ./hosts/thinker/

      self.modules.nixos.hosts-thinker-configuration
      self.modules.nixos.hosts-thinker-disko
      self.modules.nixos.hosts-thinker-lanzaboote

      self.modules.nixos.system-desktop
    ];
  };

  flake.modules.nixos.hosts-thinker-configuration = {
    networking.hostName = "thinker";
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.efi.canTouchEfiVariables = true; # Uefi related

    services.fprintd.enable = true; # Fingerprint reader

    system.stateVersion = "26.05";
  };
}
