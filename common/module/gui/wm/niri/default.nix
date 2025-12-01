# This module enables the tiling window manager `niri`.
{ pkgs, inputs, lib, ... }:
{
   imports               = [ inputs.niri.nixosModules.niri ];
   nixpkgs.overlays      = [ inputs.niri.overlays.niri     ];
   programs.niri.enable  = true;
   programs.niri.package = pkgs.niri-stable;
   # TEMP stuff:
   services.xserver.enable = true;
   programs.xwayland.enable = true; # UNSURE about this
   services.gnome.gnome-keyring.enable = true; # secret service
   security.polkit.enable              = true; # polkit
   security.pam.services.swaylock      = {};
   programs.waybar.enable              = true;
   environment.systemPackages          = with pkgs; [
      xwayland-satellite # xwayland support
      fuzzel
      swaylock
      mako
      swayidle
   ];
   
   # BAR:
   #    waybar|ironbar?
   # SHELL:
   #    noctalia|danmaterialshell|caelestia?
}

# FOR HOME.NIX:
# programs.alacritty.enable    = true; # Super+T in the default setting (terminal)
# programs.fuzzel.enable       = true; # Super+D in the default setting (app launcher)
# programs.swaylock.enable     = true; # Super+Alt+L in the default setting (screen locker)
# programs.waybar.enable       = true; # launch on startup in the default setting (bar)
# services.mako.enable         = true; # notification daemon
# services.swayidle.enable     = true; # idle management daemon
# services.polkit-gnome.enable = true; # polkit
# home.packages                = with pkgs; [
#    xwayland-satellite # xwayland support
#    swaybg             # wallpaper
# ];
