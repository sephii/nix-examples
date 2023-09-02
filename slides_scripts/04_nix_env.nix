{ pkgs, ... }: pkgs.mkShell {
  packages = [
    (pkgs.python311.withPackages (ps: [ ps.django ]))
    pkgs.nodejs
  ];

  shellHook = ''${pkgs.fortune}/bin/fortune | ${pkgs.ponysay}/bin/ponysay'';
}
