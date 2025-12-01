# This layer enables Niri and relevant things.
{ pkgs, config, lib, ... }:
{
   imports = [
      ../../../module/gui/wayland
      ../../../module/gui/wm/niri
   ];
}

