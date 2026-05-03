{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    atuin
    bat
    difftastic
    eza
    fd
    fzf
    gh
    glow
    httpie
    mise
    neovim
    ripgrep
    stylua
    uv
    zoxide
    zsh
  ];

  xdg.configFile = {
    "atuin".source = ../atuin;
    "bat".source = ../bat;
    "ghostty".source = ../ghostty;
    "git".source = ../git;
    "npm".source = ../npm;
    "nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    "psql".source = ../psql;
    "ripgrep".source = ../ripgrep;
    "tmux".source = ../tmux;
    "zsh".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zsh";
  };

  home.file.".zshenv".source = ../zshenv;
}
