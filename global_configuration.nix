# Configuration that is shared by *all* host configurations:
{ config, lib, pkgs, ... }:
{
   imports = [
      # Make `falk` a global user:
      ./users/falk
   ];

   nixpkgs.config.allowUnfree = true;
   
   nix.settings.trusted-users         = [ "falk" ];
   nix.settings.allowed-users         = [ "falk" ];
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
   boot.kernelPackages = pkgs.linuxPackages_latest;
   
   i18n.defaultLocale   = "en_IE.UTF-8";
   console.useXkbConfig = true;
   console.keyMap       = "sv-latin1";
   
   services.xserver = {
      autoRepeatDelay    = 250;
      autoRepeatInterval = 35;
      xkb.layout         = "se";
   };
   
  #programs.fish.enable = true;
   
   # TODO: Consider moving into common/ instead?
   programs.nh = {
      enable = true;
      clean  = {
         enable    = true;
         extraArgs = lib.mkDefault "--keep-since 7d --keep 20";
      };
   };
   
   environment.systemPackages = with pkgs; [
      man
      tldr
      wget
      git
      neovim 

      tree
      ripgrep
      fd
      eza
      curl
   ];
}
