# This module enables the display manager `ly`.
{ pkgs, config, lib, ... }:
{
   services .displayManager.ly = {
      enable     = true;
      x11Support = true;
   };
}

