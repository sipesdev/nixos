{ pkgs, lib, config, inputs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.file = {
    ".config/Code/User/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles/Code/User/settings.json";
    };
    ".vscode/extensions" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles/.vscode/extensions";
      recursive = true;
    };
  };

  # Stylix
  stylix.targets.vscode.enable = false;
}
