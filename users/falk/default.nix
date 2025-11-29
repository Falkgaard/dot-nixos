# System-level user configuration:
{ config, pkgs, ... }:
let
   username = builtins.baseNameOf ./.; # Using parent directory name.
in
{
   # TODO: This needs some rework...
   #       Ideally we just want some minimal data that can then be used by
   #       per-host "mkUser" function(s) that set various host-specific user settings.
   users.users.${username} = {
      name         = "${username}";
      description  = "Falkgaard";
      isNormalUser = true;
      group        = "users";
      shell        = pkgs.fish;
      packages     = with pkgs; [ fish ]; # NOTE: Keep minimal; only system level stuff.
      extraGroups  = [ "wheel" ];   # TODO: Ideally, this should be set by a per-host function.
   };
}

