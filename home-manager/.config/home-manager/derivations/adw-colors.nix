{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "adw-colors";
  version = "b290fedc46e3dc0719b9e2455ad765afe0c6a4d7";

  src = fetchFromGitHub {
    owner = "lassekongo83";
    repo = pname;
    rev = version;
    sha256 = "sha256-yksWZCu/xXp4o8B9uod5e+OZ6Kyl1IMDrcrDWVLHv74=";
  };

  installPhase = ''
    runHook preInstall

    rm -r themes/*/{*.png,*.scss,*.md}
    rm -r themes/*/{install.sh,uninstall.sh,sass}

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
