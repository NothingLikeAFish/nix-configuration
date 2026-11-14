{ inputs, self, ... }:

{
  flake.modules.nixos.system-common = {
    # MODULE IMPORTS #
    imports = with self.modules.nixos; [
      users-jasper

      system-common-packages
      system-common-packages-git
    ];

    # NIX CONFIGURATION STUFF #
    nixpkgs.config.allowUnfree = true; # Allow unfree packages
    nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable flakes and other good stuff
    nix.channel.enable = false;
    nix.optimise = { # Optimise store
      automatic = true;
      dates = "weekly";
    };
    nix.gc = { # Garbage collect
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # NETWORKING #
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;

    # TIME + LOCALES #
    services.automatic-timezoned.enable = true; # Detect time zone using location
    i18n.defaultLocale = "en_AU.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
  };
}
