{ pkgs, lib, config, inputs, ... }:

{
  programs.spicetify =
  # Define spicePkgs for Spicetify
  let 
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in 
  {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
    ];
    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}