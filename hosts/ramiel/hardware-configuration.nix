# ⚠️  PLACEHOLDER — DO NOT BOOT FROM THIS FILE.
#
# Replace the entire contents on `ramiel` with the machine's real hardware config:
#
#     sudo nixos-generate-config --show-hardware-config \
#       > hosts/ramiel/hardware-configuration.nix
#
# The values below are dummies that only let the flake *evaluate* on another
# machine — the disk label and kernel modules are fake and will not mount/boot.
{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # --- REPLACE EVERYTHING BELOW ---
  boot.initrd.availableKernelModules = [ ]; # TODO(ramiel): real modules
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # NixOS requires a root filesystem to evaluate; this label does not exist.
  fileSystems."/" = {
    device = "/dev/disk/by-label/PLACEHOLDER-REPLACE-ME";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # TODO(ramiel): confirm against your machine (the real file sets this).
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
