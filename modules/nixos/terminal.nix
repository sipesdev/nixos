{ libs, config, pkgs, inputs, ... }:

{
  # Install Alacritty
  environment.systemPackages = with pkgs; [
    alacritty
  ];
}
