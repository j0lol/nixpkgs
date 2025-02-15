{ lib, stdenv, pkg-config, darwin, fetchurl, SDL2 }:

stdenv.mkDerivation rec {
  pname = "SDL2_net";
  version = "2.2.0";

  src = fetchurl {
    url = "https://www.libsdl.org/projects/SDL_net/release/${pname}-${version}.tar.gz";
    sha256 = "sha256-TkqJGYgxYnGXT/TpWF7R73KaEj0iwIvUcxKRedyFf+s=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = lib.optional stdenv.isDarwin darwin.libobjc;

  configureFlags = lib.optional stdenv.isDarwin "--disable-sdltest";

  propagatedBuildInputs = [ (SDL2.overrideAttrs (oldattrs: rec{ dontDisableStatic = true; }) ) ];

  meta = with lib; {
    description = "SDL multiplatform networking library";
    homepage = "https://www.libsdl.org/projects/SDL_net";
    license = licenses.zlib;
    maintainers = with maintainers; [ MP2E ];
    platforms = platforms.unix;
  };
}
