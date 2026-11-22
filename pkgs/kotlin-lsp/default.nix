# MADE BY CLANKER
{pkgs}:
pkgs.stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "271.2085.0";

  src = pkgs.fetchurl {
    url = "https://download.jetbrains.com/language-server/kotlin-server/${version}/kotlin-server-${version}.tar.gz";
    sha256 = "sha256-45jnmQJ/QXSeoz+qV0cDB9E9QPkQlhhYx+MK29d4rgg=";
  };

  sourceRoot = "kotlin-server-${version}";

  dontStrip = true;
  dontPatchELF = true;

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -a . $out/
    chmod +x $out/bin/intellij-server $out/bin/restarter $out/kotlin-lsp.sh
    ln -sfn $out/bin/intellij-server $out/bin/kotlin-lsp
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "JetBrains official Kotlin Language Server (kotlin-lsp)";
    homepage = "https://github.com/Kotlin/kotlin-lsp";
    license = licenses.unfree;
    platforms = ["x86_64-linux"];
    mainProgram = "intellij-server";
  };
}
