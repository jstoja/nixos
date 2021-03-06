{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./desktop-hardware-configuration.nix
  ];
  

  networking.hostName = "wtf"; # Define your hostname.

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
