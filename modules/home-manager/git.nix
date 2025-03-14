{ pkgs, lib, config, inputs, ... }:

{
  programs.git = {
    enable = true;
    userName = "sipesdev";
    userEmail = "michael@sipes.dev";
  };
}