{ pkgs, lib, config, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      AutofillCreditCardEnabled = false;
      AutofillAddressEnabled = false;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFormHistory = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
    };
    profiles.michael = {
      id = 0;
      name = "michael";
      isDefault = true;
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        privacy-badger
        decentraleyes
        return-youtube-dislikes
      ];
      extensions.force = true;
      settings = {
        # Privacy
        "extensions.pocket.enabled" = false;
        "browser.newtabpage.pinned" = "";
        "browser.topsites.contile.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # Search
        "browser.search.defaultenginename" = "DuckDuckGo";
        "browser.search.order.1" = "DuckDuckGo";

        # Basics
        "signon.rememberSignons" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.taskbar.lists.enabled" = false;
        "browser.tabs.inTitlebar" = 0;
        "browser.compactmode.show" = true;
        "browser.cache.disk.enable" = false; # Be kind to hard drive
        "extensions.autoDisableScopes" = 0;

        # Tiling WM quirks
        "widget.disable-workspace-management" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 2;
      };
    };
  };

  # Stylix
  stylix.targets.firefox.enable = true;
  stylix.targets.firefox.profileNames = [ "michael" ];
  stylix.targets.firefox.colorTheme.enable = true;
  stylix.targets.firefox.firefoxGnomeTheme.enable = true;
}