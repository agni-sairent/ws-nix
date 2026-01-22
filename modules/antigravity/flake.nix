{ config, pkgs, lib, ... }:

{
  # If you use Google Chrome (unfree), this must be enabled somewhere.
  # You can keep it here if you want it "Antigravity-owned".
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    antigravity
    # Browser Antigravity can launch:
    google-chrome
    # Playwright browsers bundle that works on NixOS:
    playwright-driver.browsers
  ];

  # Make Playwright use the Nix-provided browsers (so it doesn't download its own).
  environment.sessionVariables = {
    PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
    # Sometimes needed depending on tooling:
    PLAYWRIGHT_HOST_PLATFORM_OVERRIDE = "ubuntu-24.04";

    # Optional: some apps look for these:
    CHROME_BIN = "${pkgs.google-chrome}/bin/google-chrome-stable";
    CHROME_PATH = "${pkgs.google-chrome}/bin/google-chrome-stable";
  };
}
