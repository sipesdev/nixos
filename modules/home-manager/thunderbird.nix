{ pkgs, lib, config, inputs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.michael = {
      id = 0;
      name = "michael";
      isDefault = true;
    };
  };
}