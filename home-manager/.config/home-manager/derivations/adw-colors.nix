{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "adw-colors";
  version = "4f32945ffe95e871b46191d96dc5f61b153d699f";

  src = fetchFromGitHub {
    owner = "lassekongo83";
    repo = pname;
    rev = version;
    sha256 = "sha256-ocrVOebwU2AN4MAQywTOHEA8Lwbx7iOMbuI85V5jk4I=";
  };

  installPhase = ''
    runHook preInstall

    rm -r themes/*/{*.png,*.scss,*.md}

    mkdir -p $out
    cp -r themes $out/themes

    runHook postInstall
  '';

  meta = with lib; {
    description = "Color themes for libadwaita and adw-gtk3 ";
    homepage = "A feature-full Polybar module to control PulseAudio";
    platforms = platforms.linux;
  };
}
