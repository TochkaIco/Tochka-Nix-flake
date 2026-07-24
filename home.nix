{ config, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # Basic user information
  home.username = "tochka";
  home.homeDirectory = "/home/tochka";

  home.stateVersion = "26.05";

  home.sessionVariables = {
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_SIZE = "24";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  # Keeps your pointer cursor synced automatically
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  }; 

  gtk = {
    enable = true;
    iconTheme = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, T, exec, foot"
    ];
  };

  xdg.configFile."caelestia/hypr-vars.lua" = {
    text = ''
      return {
        fileExplorer = "dolphin",
      }
    '';
    force = true;
  }; 

  # User-only packages
  home.packages = [
    inputs.caelestia-cli.packages.${pkgs.stdenv.hostPlatform.system}.with-shell
    pkgs.fuzzel
    pkgs.cliphist
    pkgs.wl-clipboard
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.gpu-screen-recorder
    pkgs.hyprpicker
    pkgs.vscodium
    pkgs.thunar
    pkgs.pavucontrol
    pkgs.todoist  
];

  # Program configurations
  programs.git = {
    enable = true;

    settings.user.name = "Fedor Romanov";
    settings.user.email = "fedor1378romanov@gmail.com";

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
      format = "ssh";
    };
  };

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # ... your other options (home.packages, pointerCursor, etc.) ...

  programs.spicetify = {
    enable = true;

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      shuffle
    ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
 
  # Vis config
  # xdg.configFile."vis/visrc.lua".source = ./visrc.lua;
}
