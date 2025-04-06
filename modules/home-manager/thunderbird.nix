{ pkgs, lib, config, inputs, ... }:

{
  programs.thunderbird = {
    enable = true;
  };
}