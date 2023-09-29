{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, pulseaudio
}:

stdenv.mkDerivation rec {
  pname = "polybar-pulseaudio-control";
  version = "v3.1.1";

  src = fetchFromGitHub {
    owner = "marioortizmanero";
    repo = pname;
    rev = version;
    sha256 = "0mzmdb4y5sfrpar73p8aknhzz6sjgnhsbr702p573637g058203s";
  };

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    runHook preInstall

    install -D ./pulseaudio-control.bash $out/bin/pulseaudio-control

    wrapProgram $out/bin/pulseaudio-control \
      --prefix PATH ":" ${lib.makeBinPath [pulseaudio]}

    runHook postInstall
  '';

  meta = with lib; {
    description = "A feature-full Polybar module to control PulseAudio";
    homepage = "https://github.com/marioortizmanero/polybar-pulseaudio-control";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
