{
  description = "Basic Python dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python313;
      pkg = pkgs.python313Packages;
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          python
        ];

        shellHook = ''
              echo "$(python --version)"
              # если есть fish
            if [ -n "$FISH_VERSION" ]; then
              fish
          else if [ -n "$BASH_VERSION" ]; then
                bash
            fi
        '';
      };
    });
}
