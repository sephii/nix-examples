{
  inputs.systems.url = "github:nix-systems/default";
  inputs.devenv.url = "github:cachix/devenv/9ba9e3b908a12ddc6c43f88c52f2bf3c1d1e82c1";

  outputs = { self, nixpkgs, devenv, systems, ... }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = import nixpkgs { inherit system; };
            packageOverrides = prev: final: { django = final.django_4; };
            python = pkgs.python311.override {
              inherit packageOverrides;
              self = python;
            };
            pythonEnv = pkgs.python311.withPackages (ps: [
              (ps.django_4.override { withGdal = true; })
              ps.psycopg2
            ]);
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  services.postgres = {
                    enable = true;
                    initialDatabases = [ { name = "myproject"; } ];
                    extensions = (extensions: [ extensions.postgis ]);
                  };

                  scripts.dj.exec = "${pythonEnv.interpreter} -m django $@";

                  packages = [
                    pythonEnv
                  ];

                  processes.runserver.exec = "${pythonEnv.interpreter} -m django runserver";

                  env = {
                    DATABASE_URL = "postgresql:///myproject";
                    DJANGO_SETTINGS_MODULE = "myproject.settings";
                  };
                }
              ];
            };
          });
    };
}

