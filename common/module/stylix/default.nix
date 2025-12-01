# This module enables Stylix for the host machines that import it.
{ pkgs, inputs, lib, ... }: #config, lib, ...
{
   imports = [ inputs.stylix.nixosModules.stylix ];
   
   stylix = {
      enable       = true;
      autoEnable   = true;
      
      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      
      image        = lib.mkDefault ./default_wallpaper.png;
      
      cursor = lib.mkDefault {
         name    = "Bibata-Modern-Classic"; # "Adwaita";
         package = pkgs.bibata-cursors;     # pkgs.adwaita-icon-theme;
         size    = lib.mkDefault 36;        # 14;
      };
      
      fonts = lib.mkDefault {
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
         
         sizes = lib.mkDefault {
            applications = lib.mkDefault 16;
            desktop      = lib.mkDefault 16;
            popups       = lib.mkDefault 16;
            terminal     = lib.mkDefault 16;
         };
      };
      
      opacity = lib.mkDefault {
         applications = lib.mkDefault 1.00;
         desktop      = lib.mkDefault 1.00;
         terminal     = lib.mkDefault 1.00;
         popups       = lib.mkDefault 1.00;
      };
   };
}

