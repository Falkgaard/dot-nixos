# Configuration that is shared by *all* host configurations:
{ config, lib, pkgs, ... }:
{
   imports = [
      # Make `falk` a global user:
      ./users/falk
   ];
   
   nix.settings.trusted-users         = [ "falk" ];
   nix.settings.allowed-users         = [ "falk" ];
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
   boot.kernelPackages = pkgs.linuxPackages_latest;
   
   i18n.defaultLocale = "en_IE.UTF-8";
   console = {
      font         = "Lat2-Terminus16";
      useXkbConfig = true;
   };
   
   services.xserver = {
      autoRepeatDelay    = 250;
      autoRepeatInterval = 35;
      xkb.layout         = "se";
   };
   
  #programs.fish.enable = true;
   
   programs.nh = {
      enable = true;
      clean  = {
         enable    = true;
         extraArgs = "--keep-since 7d --keep 20";
      };
   };
   
   environment.systemPackages = with pkgs; [
      man
      tldr
      wget
      git
      neovim 
   ];
}
