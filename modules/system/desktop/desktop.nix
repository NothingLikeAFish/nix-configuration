{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop = {
    # MODULE IMPORTS #
    imports = with self.modules.nixos; [
      system-common

      system-desktop-packages-sway
      system-desktop-packages-fonts
    ];

    # AUDIO #
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # PRINTING #
    services.printing.enable = true;


    # Add bluetooth and tlp or smth
  };
}
