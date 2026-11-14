{ inputs, self, ... }:

{
  flake.modules.nixos.system-common-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      curl
      tree
      micro
    ];
  };
}
