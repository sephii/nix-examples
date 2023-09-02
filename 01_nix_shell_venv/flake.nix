{
  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    python = pkgs.python311;
  in {
    devShells.${system}.default = pkgs.mkShell {
      venvDir = "./.venv";

      packages = [
        python
        python.pkgs.venvShellHook
        pkgs.nodejs
      ];

      postVenvCreation = ''
        unset SOURCE_DATE_EPOCH
        pip install -r requirements.txt
      '';

      postShellHook = ''
        unset SOURCE_DATE_EPOCH
      '';
    };
  };
}
