{ lib
, buildNpmPackage
, fetchFromGitHub
, nix-update-script
}:

buildNpmPackage rec {
  pname = "ansible-language-server";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "ansible";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-+42fZ4ILUHg/KcnllUaFYYPBKHxauagbsVdIY1MgwSI=";
  };

  npmDepsHash = "sha256-DRXIbIogMeiJvZOB44hKkkfc3dg8mscnV6k2rUvYCNs=";
  npmBuildScript = "compile";

  # We remove the prepare and prepack scripts because they run the
  # build script, and therefore are redundant.
  #
  # Additionally, the prepack script runs npm ci in addition to the
  # build script. Directly before npm pack is run, we make npm unaware
  # of the dependency cache, causing the npm ci invocation to fail,
  # wiping out node_modules, which causes a mysterious error stating that tsc isn't installed.
  postPatch = ''
    sed -i '/"prepare"/d' package.json
    sed -i '/"prepack"/d' package.json
  '';

  passthru.updateScript = nix-update-script {
    attrPath = pname;
  };

  meta = with lib; {
    changelog = "https://github.com/ansible/ansible-language-server/releases/tag/v${version}";
    description = "Ansible Language Server";
    homepage = "https://github.com/ansible/ansible-language-server";
    license = licenses.mit;
    maintainers = with maintainers; [ hexa ];
  };
}
