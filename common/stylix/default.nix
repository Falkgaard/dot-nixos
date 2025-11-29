# This module enables Stylix for the host machines that import it.
{ pkgs, config, lib, ... }:
{
   stylix = lib.mkDefault {
      enable       = true;
      autoEnable   = true;
      
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      
      image        = ./default_wallpaper.png;
      
      cursor = {
         name    = "Bibata-Modern-Classic"; # "Adwaita";
         package = pkgs.bibata-cursors;     # pkgs.adwaita-icon-theme;
         size    = 36;                      # 14;
      };
      
      fonts = {
         serif = {
            package = pkgs.dejavu_fonts;
            name    = "DejaVu Serif";
         };
         
         sansSerif = {
            package = pkgs.dejavu_fonts;
            name    = "DejaVu Sans";
         };
         
         monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name    = "JetBrainsMono Nerd Font";
         };
         
         emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name    = "Noto Color Emoji";
         };
         
         sizes = {
            applications = 16;
            desktop      = 16;
            popups       = 16;
            terminal     = 16;
         };
      };
      
      opacity = {
         applications = 1.00;
         desktop      = 1.00;
         terminal     = 1.00;
         popups       = 1.00;
      };
   };
}

