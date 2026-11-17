{
  flake.colours = builtins.fromJSON ( # Very hacky way of flake wide colours
      builtins.readFile (
        with inputs.nixpkgs.legacyPackages.x86_64-linux;
        runCommand "colours.json"
          {
            nativeBuildInputs = [ flavours yq-go ];
          }
          ''
            flavours generate dark "${self.wallpaper}" --stdout | yq -o=json '.' > "$out"
          ''
      )
    );
}
