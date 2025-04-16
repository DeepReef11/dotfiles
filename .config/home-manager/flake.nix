{
  description = "Home Manager configuration of jo";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nvf = {
    #   url = "github:notashelf/nvf";
    #   # You can override the input nixpkgs to follow your system's
    #   # instance of nixpkgs. This is safe to do as nvf does not depend
    #   # on a binary cache.
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   # Optionally, you can also override individual plugins
    #   # for example:
    #   # inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
    # };
    nvf-config = {
      url = "path:./nvf-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nvf-config, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."jo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass inputs to home.nix
        extraSpecialArgs = { inherit inputs; inherit nvf-config; };

        modules = [
          ./home.nix
        ];
      };
    };

}
