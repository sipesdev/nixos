{ lib, config, pkgs, inputs, ...  }:

{
  # Install common fonts
  fonts.enableDefaultPackages = true;
  
  # Install specific fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];
}
