{ pkgs, git ? "", ... }: {
  # Shell script that produces the final environment
  bootstrap = ''
    cp -rf ${./.}/files "$WS_NAME"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"

    # Remove the template files themselves and any connection to the template's
    # Git repository
    rm -rf "$out/.git" "$out/idx-template".{nix,json}
  '';
}
