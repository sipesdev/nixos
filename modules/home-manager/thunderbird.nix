{ pkgs, lib, config, inputs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.michael = {
      name = "michael";
      isDefault = true;
    };
  };
}