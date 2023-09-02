{ pkgs, ... }: {
  enterShell = ''
    echo "Run just -l to see the list of available commands"
  '';

  languages.python.enable = true;
  languages.python.package = pkgs.python311;
  languages.python.poetry.enable = true;
  languages.python.poetry.activate.enable = true;

  #processes = {
  #  runserver.exec = "poetry run -- python -m django runserver";
  #};

  services.postgres.enable = true;
  services.mailhog.enable = true;

  pre-commit.hooks.ruff.enable = true;
  pre-commit.hooks.black.enable = true;

  scripts.dj.exec = "python -m django $@";

  packages = [ pkgs.nodejs-18_x ];
}
