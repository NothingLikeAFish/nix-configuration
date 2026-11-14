{ inputs, self, ... }:

{
  flake.modules.nixos.system-common-packages-git = { pkgs, ... }: {
    environment.systemPackages = with self.packages.${pkgs.stdenv.hostPlatform.system}; [
      git
    ];
  };

  flake.wrappers.git = { wlib, pkgs, ... }: {
    imports = [ wlib.wrapperModules.git ];
    settings = {
      user = {
        name = "Jasper";
        email = "blueybydown@gmail.com";
      };
    };
  };
}
