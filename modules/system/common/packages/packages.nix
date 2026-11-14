{ inputs, self, ... }:

{
  flake.modules.nixos.system-common-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
      curl
      tree
      micro
    ];
  };
}
