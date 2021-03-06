{ stdenv, fetchFromGitHub, pandoc, installShellFiles, withManpage ? false }:

stdenv.mkDerivation rec {
  pname = "earlyoom";
  version = "1.6.2";

  src = fetchFromGitHub {
    owner = "rfjakob";
    repo = "earlyoom";
    rev = "v${version}";
    sha256 = "16iyn51xlrsbshc7p5xl2338yyfzknaqc538sa7mamgccqwgyvvq";
  };

  nativeBuildInputs = stdenv.lib.optionals withManpage [ pandoc installShellFiles ];

  patches = [ ./fix-dbus-path.patch ];

  makeFlags = [ "VERSION=${version}" ];

  installPhase = ''
    install -D earlyoom $out/bin/earlyoom
  '' + stdenv.lib.optionalString withManpage ''
    installManPage earlyoom.1
  '';

  meta = with stdenv.lib; {
    description = "Early OOM Daemon for Linux";
    homepage = "https://github.com/rfjakob/earlyoom";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [];
  };
}
