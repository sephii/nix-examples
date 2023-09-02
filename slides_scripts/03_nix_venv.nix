{ pkgs, ... }: pkgs.mkShell {
  venvDir = "./.venv";

  packages = [
    pkgs.python311
    pkgs.python311.pkgs.venvShellHook
    pkgs.nodejs
  ];

  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install -r requirements.txt
  '';

  postShellHook = ''
    unset SOURCE_DATE_EPOCH
  '';
}
