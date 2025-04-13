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
        install = ''
          git clone https://github.com/Kinto/kinto folder_to_be_deleted
          mv folder_to_be_deleted/* folder_to_be_deleted/.* .
          rm -rf folder_to_be_deleted

          python -m venv .venv
          source .venv/bin/activate

          pip install --upgrade pip 
          if test -f requirements.txt; then
            pip install -r requirements.txt
          fi

          exit 0
        '';
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
