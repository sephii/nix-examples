{ buildPythonPackage
, fetchFromGitHub
, django_4
, dateutil
, django_tables2
, ...
}: buildPythonPackage rec {
  pname = "my_package";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "sephii";
    repo = "my_package";
    rev = "v${version}";
    hash = "sha256-s89gs3H//Dc3k6BLZUC4APyDgiWY9LetWAkI+kXQTf8=";
  };

  buildInputs = [ django_4 dateutil django_tables2 ];
}
