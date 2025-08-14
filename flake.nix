# flake.nix
{
  description = "My Home Manager configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    timr.url = "github:sectore/timr-tui";
  };
  
  outputs = { nixpkgs, home-manager, timr, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        holo = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ];
          extraSpecialArgs = { timr = timr; system = system; };
        };
      };
    };
}


