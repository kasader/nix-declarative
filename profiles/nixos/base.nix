{ lib, pkgs, ... }:
{
  # Baseline system config every NixOS host gets. The *home* side (shell, git,
  # editors, …) is provided by profiles/home/base.nix via integrated home-manager;
  # this file owns only what must live at the system level.
  #
  # Everything marked TODO(ramiel) is a placeholder — confirm/replace it against
  # your existing /etc/nixos/configuration.nix when you migrate on the machine.
  imports = [ ../../modules/nixos ];

  # Flakes + modern nix CLI.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # TODO(ramiel): bootloader. systemd-boot assumes UEFI; switch to grub if BIOS.
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  # TODO(ramiel): locale / timezone.
  time.timeZone = lib.mkDefault "Asia/Tokyo";
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  # TODO(ramiel): networking. NetworkManager is the safe default for a workstation.
  networking.networkmanager.enable = lib.mkDefault true;

  # NixOS owns the *account*; home-manager owns the account's *home*. Fish is the
  # login shell everywhere, so it must be enabled at the system level to be valid.
  programs.fish.enable = true;
  users.users.kasada = {
    isNormalUser = true;
    description = "kasada";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
    # TODO(ramiel): set an initial password with `passwd` after first boot, or
    # manage it declaratively (hashedPasswordFile) once secrets are wired up.
  };

  # Minimal system-level packages; the bulk lives in home-manager.
  environment.systemPackages = with pkgs; [ git vim ];
}
