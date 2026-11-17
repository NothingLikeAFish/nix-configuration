{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop = {
    # MODULE IMPORTS #
    imports = with self.modules.nixos; [
      system-common

      system-desktop-packages
      system-desktop-packages-sway
      system-desktop-packages-fonts
      system-desktop-packages-foot
    ];

    # AUDIO #
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # PRINTING #
    services.printing.enable = true;

    # BLUETOOTH
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    environment.systemPackages = with pkgs; [
      bluetui
    ];
  };
}
