{ inputs, self, ... }:

#sudo nix run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake .#thinker --disk main /dev/nvme0n1

{
  flake.modules.nixos.hosts-thinker-disko = { # Partitions
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk = {
        main = {
          device = "/dev/nvme0n1";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              esp = { # Boot/esp partition
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ]; # Sets permissions to root only
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" ];
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "@swap" = {
                      mountpoint = "/.swap";
                      swap.swapfile.size = "8G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
