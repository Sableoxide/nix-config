{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sableoxide";
  home.homeDirectory = "/home/sableoxide";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  backupFileExtension = "backup";

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # for kde connect
  services.kdeconnect.enable = true;

  #gtk fonts
  gtk.enable = true;

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1"; # or use a commit hash
          sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo="; # placeholder
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "master"; # or use a commit hash
          sha256 = "sha256-KRsQEDRsJdF7LGOMTZuqfbW6xdV5S38wlgdcCM98Y/Q="; # placeholder
        };
      }
    ];

    oh-my-zsh = { # "ohMyZsh" without Home Manager
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };

    shellAliases = {
      ll = "ls -l";
      # dont use this migrated to flakes (this will rebuild to an old system)
      nrs-preflake = "sudo nixos-rebuild switch";
      hms-preflake= "home-manager switch";
      # FLAKE
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-system-flake/.#nixos-btw";
      hms = "home-manager switch -b backup --flake ~/nixos-system-flake/.#sableoxide@nixos-btw";
      # CLEAN GRUB ENTRIES
      clean-grub-entries = "sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system && sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch";
    };
    history.size = 5000;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    git
    cacert
    qbittorrent
    neofetch
    openjdk8
    bat
    networkmanagerapplet

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sableoxide/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
