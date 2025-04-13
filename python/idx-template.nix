{ pkgs, repoURL ? "", ... }: {
  # Shell script that produces the final environment
  packages = [
    pkgs.j2cli
    pkgs.nixfmt
  ];
  bootstrap = ''
    cp -rf ${./.}/files "$WS_NAME"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"

    reporURL=${repoURL} j2 ${./devNix.js}  -o "$WS_NAME"/.idx/dev.nix
    nixfmt "$WS_NAME"/.idx/dev.nix

    # Remove the template files themselves and any connection to the template's
    # Git repository
    rm -rf "$out/.git" "$out/idx-template".{nix,json}
  '';
}
