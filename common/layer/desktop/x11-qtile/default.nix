# This layer enables qtile and relevant things.
{ pkgs, config, lib, ... }:
{
   imports = [
      ../../../module/gui/x11
      ../../../module/gui/wm/qtile
   ];
}

