{ pkgs, lib, config, inputs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.michael = {
      isDefault = true;
    };
  };

  home.file = {
    ".thunderbird/profiles.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles/.thunderbird/profiles.ini";
    };
    ".thunderbird/michael/prefs.js" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles/.thunderbird/michael/prefs.js";
    };
  };
}