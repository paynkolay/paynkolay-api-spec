{
  description = "PayNKolay API Spec";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      makePkgs = system: import nixpkgs { inherit system; };
    in
    {
    devShells = forAllSystems (system: let
      pkgs = makePkgs system;
    in {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.openapi-generator-cli
          pkgs.nodejs
          pkgs.redocly
        ];
      };
    });
  };
}
