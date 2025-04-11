# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python312
    pkgs.python312Packages.pip
  ];
  # Sets environment variables in the workspace
  env = {
    # USER_AGENT = "";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "google.geminicodeassist"
      "googlecloudtools.cloudcode"      
      "ms-python.autopep8"
      "ms-python.debugpy"
      "ms-python.python"
    ];
    # Enable previews
    previews = {
      enable = true;
      previews = {
        # web = {
        #   # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
        #   # and show it in IDX's web preview panel
        #   command = ["npm" "run" "dev"];
        #   manager = "web";
        #   env = {
        #     # Environment variables to set for your server
        #     PORT = "$PORT";
        #   };
        # };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        install =
          "echo install-start $(date) && python -m venv .venv && source .venv/bin/activate && echo install-end $(date) && echo clone-start $(date) && git clone https://github.com/Kinto/kinto.git && echo clone-end $(date) echo move-start $(date) && mv kinto tmp_to_delete && mv tmp_to_delete/* tmp_to_delete/.* . && rm -rf tmp_to_delete && echo move-end $(date) && exit";
        # clone =
          # "echo clone-start $(date) && git clone https://github.com/Kinto/kinto.git && echo clone-end $(date) && exit";
        # move =
          # "echo move-start $(date) && mv kinto tmp_to_delete && mv tmp_to_delete/* tmp_to_delete/.* . && rm -rf tmp_to_delete && echo move-end $(date) && exit";
        # Example: install JS dependencies from NPM
        # npm-install = "npm install";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "README.md" ];
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
        # install =
          # "source .venv/bin/activate";
      };
    };
  };
}
