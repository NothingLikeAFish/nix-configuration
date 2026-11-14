{ inputs, self, ... }:

{
  flake.modules.nixos.users-jasper = {
    users.users.jasper = {
      isNormalUser = true;
      description = "Jasper";
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "1234";
    };
  };
}
