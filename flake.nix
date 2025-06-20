{
  description = "invert.nvim development environmnet";

  inputs = {
    flake-utils.url = "github.com:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    {
      flake-utils,
      nixpkgs,
      ...
    }@inputs:
    flake-utils.eachDefaultSystem (
      system:
      let
        luaPkgs = nixpkgs.luajitPackages;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with luaPkgs; [
            luajit
            luarocks
            busted
          ];

          shellHook = ''
            echo "Lua: $(lua --version)"
            echo "Rocks: $(luarocks --version)"
          '';
        };
      }
    );
}
