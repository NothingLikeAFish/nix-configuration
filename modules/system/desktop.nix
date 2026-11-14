{ inputs, self, ... }:

{
  flake.modules.nixos.system-desktop = {
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
  };
}
