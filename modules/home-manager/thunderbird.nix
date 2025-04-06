{ pkgs, lib, config, inputs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.michael = {
      isDefault = true;
    };
  };
}