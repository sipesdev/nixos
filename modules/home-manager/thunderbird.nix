{ pkgs, lib, config, inputs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.michael = {
      isDefault = true;
    };
  };

  home.file = {
    # Reverse symlink to update home files in my git directory to sync
    "repos/dotfiles/.thunderbird/profiles.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.thunderbird/profiles.ini";
    };
    "repos/dotfiles/.thunderbird/michael" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.thunderbird/";
      recursive = true;
    };
  };
}