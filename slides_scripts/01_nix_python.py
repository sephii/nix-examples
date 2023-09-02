def my_package(
    buildPythonPackage,
    fetchFromGitHub,
    django_4, dateutil,
    django_tables2,
    **kwargs
):
    version = "1.0.0"

    return buildPythonPackage(
        pname="my_package",
        version=version,
        src=fetchFromGitHub(
            owner="sephii",
            repo="my_package",
            rev=f"v{version}",
            hash="sha256-s89gs3H//Dc3k6BLZUC4APyDgiWY9LetWAkI+kXQTf8=",
        ),
        buildInputs=[django_4, dateutil, django_tables2],
    )
