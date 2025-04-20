{ pkgs, lib, config, inputs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.file = {
    # Reverse symlink to update home files in my git directory to sync
    "repos/dotfiles/Code/User/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Code/User/settings.json";
    };
    "repos/dotfiles/.vscode/extensions/extensions.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.vscode/extensions/extensions.json";
    };
  };

  # Stylix
  stylix.targets.vscode.enable = false;
}
