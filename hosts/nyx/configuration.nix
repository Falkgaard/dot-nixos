# Configuration that is specific to this host:
{ pkgs, config, lib, ... }:
{
   imports = [
     #../../common/home-manager # NOTE: Doesn't seem to have any associated enable at the system level..?
      ../../common/stylix
   ];
   
   networking.networkmanager.enable = true;
   
   #############################################################################################
   boot = {
      #kernelModules = [
      #   "vsock"    # VMware communication
      #   "vmw_vmci" # guest↔host channel
      #   "vmwgfx"   # virtual GPU driver
      #];
      loader = {
         #systemd-boot = {
         #   enable       = true;
         #   consoleMode  = "max";
         #   extraEntries = ''
         #                     options vga=1920x1080
         #                  '';
         #};
          grub = {
             enable                = true;
             efiSupport            = true;
             gfxmodeEfi            = "1920x1080"; # Doesn't seem to apply...
            #efiInstallAsRemovable = true;
             device                = "nodev";
             font                  = lib.mkForce "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
             fontSize              = lib.mkForce 36;
             extraEntries          = ''
                                        set linux_video_mode=1920x1080
                                        set grub_video_mode=1920x1080
                                     '';
         };
         efi = {
            efiSysMountPoint     = "/boot";
            canTouchEfiVariables = true;
         };
      };
   };
    
   nixpkgs.config.allowUnfree = true;
   # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   #    "ec2-api-tools"
   # ];
   # nixpkgs.config.packageOverrides = pkgs: {
   #    mesa = pkgs.mesa.override { galliumDrivers = [ "svga" ]; };
   # };
   
   virtualisation.vmware.guest.enable = true;
 
   hardware = {
      #cpu.amd.updateMicrocode = true;
      graphics = {
         enable      = true;
         enable32Bit = true;
         # extraPackages = with pkgs; [ mesa ];
      };
      #nvidia = {
      #   open               = true;
      #  #modesetting.enable = true;
      #};
   };
 
   services = {
      # displayManager.sddm = {
      #    enable      = true;
      #    enableHidpi = true;
      # };
      displayManager.ly = {
         enable     = true;
         x11Support = true;
      };
      xserver = {
         enable                     = true;
        #dpi                        = 80;
        #videoDrivers               = [ "amdgpu" ];
         windowManager.qtile.enable = true;
      };
   };

   # Display scaling (HiDPI VM) -- TODO: refactor
   environment.variables = {
      GDK_SCALE                       = "1.5";
      QT_AUTO_SCREEN_SCALE_FACTOR     = "1.5";
      WEBKIT_DISABLE_COMPOSITING_MODE = "1";
      FALK_VERSION                    = "0.1.7 -- ?";
   };
   #############################################################################################
   # Audio:
   security.rtkit.enable = true; # optional
   services.pipewire = {
      enable            = true; # if not already enabled
      alsa.enable       = true;
      alsa.support32Bit = true;
      pulse.enable      = true;
      # If you want to use JACK applications, uncomment the following
      #jack.enable = true;
   };
   #############################################################################################
   # NOTE: Should make Qt5 apps look like GTK ones.
   # qt = {
   #    enable        = true;
   #    platformTheme = "gtk2";
   #    style         = "gtk2";
   # };
   #############################################################################################

   time.timeZone      = "Europe/Malta";
   console.font       = "Lat2-Terminus16";
   console.earlySetup = true;
 
   programs.firefox.enable = true;
   programs.fish.enable    = true;
   
   environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      kdePackages.qtsvg # NOTE: Needed for icons in Dolphin
      kitty
      picom
   ];

   fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
   
   system.stateVersion = "25.05"; # Do not edit.
}

