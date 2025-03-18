{ pkgs, lib, config, inputs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-dotnettools.csharp
        ms-dotnettools.csdevkit
        ms-vscode.cpptools
        ms-vscode.cmake-tools
        ms-python.python
        ms-python.debugpy
        redhat.vscode-xml
        redhat.vscode-yaml
        redhat.java
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        jnoortheen.nix-ide
        continue.continue
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "update.mode" = "none";
        "editor.minimap.enabled" = false;
        "editor.stickyScroll.enabled" = false;
      };
    };
  };
}
