{ pkgs, config, lib, ... }:
{
   imports = [
     #../../common/home-manager # NOTE: Doesn't seem to have any associated enable at the system level..?
      ../../common/stylix
   ];

   boot = {
      kernelModules  = [ "btusb" "hidp" ];
      loader = {
         efi = {
	    canTouchEfiVariables = true;
	    #efiSysMountPoint = "/boot/EFI";
         };
         systemd-boot = {
            enable      = true;
            consoleMode = "max";
	 };
      };
   };

   hardware = {
      graphics.enable = true;
      #enable32Bit = true;
      nvidia = {
         open               = false;
	 modesetting.enable = true;
	 nvidiaSettings     = true;
	 powerManagement = {
	    enable      = false;
	    finegrained = false;
         };
	 package = config.boot.kernelPackages.nvidiaPackages.stable;
	 prime = {
	    # offload.enable = false;
	    # sync.enable    = false;
	    nvidiaBusId      = "PCI:0:1:0";
	    intelBusId       = "PCI:0:0:2";
	 };
      };
   };

   hardware.bluetooth.enable = true;
  #services.rfkill.enable    = true;

   networking = {
     #wireless.enable       = true;
     #useDHCP               = true;
      networkmanager.enable = true;
   };

   services = {
      displayManager.ly = {
         enable     = true;
	 x11Support = true;
      };
      xserver = {
         enable                     = true;
	 windowManager.qtile.enable = true;
	 xkb.layout                 = "se";
	 videoDrivers               = [ "modesetting" "nvidia" ];
      };
   };

   environment.variables = {
      GTK_SCALE                   = "1.5";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
      FALK_VERSION                = "0.0.0";
   };

   security.rtkit.enable = true;
   services.pipewire = {
      enable            = true;
      alsa.enable       = true;
      alsa.support32Bit = true;
      pulse.enable      = true;
   };

   time.timeZone      = "Europe/Malta";
   console.font       = "Lat2-Terminus16";
   console.earlySetup = true;

   programs.fish.enable = true;
   programs.firefox.enable = true;

   programs.nh = {
      enable = true;
      clean  = {
         enable    = true;
	 extraArgs = "--keep 32";
      };
   };

   environment.systemPackages = with pkgs; [
      kitty
      networkmanagerapplet
      networkmanager # nmtui
      blueman
      bluez # bluetoothctl

      picom
      kdePackages.dolphin
      kdePackages.qtsvg # NOTE: Needed for icons in Dolphin.
   ];

   fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

   system.stateVersion = "24.05"; # Do not edit.
}

