{
  description = "invert.nvim development environmnet";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    {
      flake-utils,
      nixpkgs,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        luaPkgs = pkgs.lua51Packages;

        inherit (pkgs) mkShell;
        inherit (pkgs.lib.attrsets) mapAttrs;

        packages = with pkgs; [
          lua
          neovim
        ];

        versions =
          # sh
          ''
            echo "Lua    $(lua -v | cut -d ' ' -f 2)"
            echo "Rocks  $(luarocks --version | head -n 1 | cut -d ' ' -f 2)"
            echo "Busted $(busted --version)"
          '';
      in
      {
        devShells = mapAttrs (_: mkShell) {
          default = {
            inherit packages;
            shellHook = versions;
          };
          fish = {
            packages = packages ++ [ pkgs.fish ];
            shellHook = ''
              ${versions}
              exec fish
            '';
          };
          test = {
            packages =
              packages
              ++ (with luaPkgs; [
                busted
                luacov
                nlua
              ]);
            shellHook = ''
              ${versions}
              exec busted ./tests/
              exit $?
            '';
          };
        };
      }
    );
}
