{
   # NOTE: Use `nix flake update` to update the flake to the
   #       latest revision of the chosen release channel.
   
   description = "Falk's NixOS (unstable channel) system configuration flake.";
   
   # System flake inputs:
   inputs = {
      # Chosen NixOS release channel:
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      
      # # User home environment manager:
      # home-manager = {
      #    url                    = "github:nix-community/home-manager";
      #    inputs.nixpkgs.follows = "nixpkgs";
      # };
      
      # Theming framework:
      stylix = {
         url                    = "github:nix-community/stylix";
         inputs.nixpkgs.follows = "nixpkgs";
      };
   };
   
   outputs = inputs@{ self, nixpkgs, /*home-manager,*/ stylix, ... }:
   let
      # Get the list of hosts declared inside of `./hosts/`:
      hostnames = builtins.filter (dir: dir != ".") (builtins.attrNames (builtins.readDir ./hosts));
      
      # Custom nixosSystem wrapper function:
      mkNixosSystem = hostname: nixpkgs.lib.nixosSystem {
         #system = import ./hosts/${hostname}/system.nix; ?
         modules = [
	    # Adding flake input modules:
	    # home-manager.nixosModules.home-manager
	    stylix.nixosModules.stylix
            # Configuration shared by *all* hosts:
            ./global_configuration.nix 
            # Host-specific configuration:
            ./hosts/${hostname}/configuration.nix
            ./hosts/${hostname}/hardware-configuration.nix
            {
               networking.hostName = nixpkgs.lib.mkDefault "${hostname}";
            }
         ];
      };
   in
   {
      # Generate a NixOS system configuration for each hostname:
      nixosConfigurations = nixpkgs.lib.genAttrs (hostnames) (hostname: mkNixosSystem hostname);
   };
   
}

