{ lib
, aiohttp
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "life360";
  version = "5.4.1";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "pnbruckner";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-uFKRWTFrc1AYn0Rc8HhcVPkmdAbwFJuj8tXZjglGq8E=";
  };

  propagatedBuildInputs = [
    aiohttp
  ];

  # Project has no tests
  doCheck = false;

  pythonImportsCheck = [
    "life360"
  ];

  meta = with lib; {
    description = "Python module to interact with Life360";
    homepage = "https://github.com/pnbruckner/life360";
    changelog = "https://github.com/pnbruckner/life360/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
