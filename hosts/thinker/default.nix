{ inputs, self, ... }:

{
  flake.nixosConfigurations.thinker = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./_hardware-configuration.nix

      self.modules.nixos.hosts-thinker-disko
      self.modules.nixos.hosts-thinker-lanzaboote
    ];
  };
}
