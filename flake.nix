{
  description = "invert.nvim development environment";

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

        inherit (pkgs) lib mkShell;
        inherit (lib.attrsets) mapAttrs;

        packages = with pkgs; [
          lua5_1
          neovim
        ];

        testPackages = with pkgs; [
          (lua5_1.withPackages (
            p: with p; [
              nlua
              busted
              luacov
            ]
          ))
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
        };
        apps.test = {
          type = "app";
          program = lib.getExe (
            pkgs.writeShellApplication {
              name = "busting-makes-me-feel-good";
              runtimeInputs = packages ++ testPackages;
              text =
                # sh
                ''
                  busted ./tests/
                '';
            }
          );
        };
      }
    );
}
