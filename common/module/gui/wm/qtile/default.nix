# This module enables the tiling window manager `qtile`.
{ pkgs, config, lib, ... }:
{
   services.xserver.windowManager.qtile.enable = true;
   environment.systemPackages = with pkgs; [ picom ];
}

