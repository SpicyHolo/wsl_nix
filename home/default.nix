{ lib, pkgs, timr, system, ... }: 
let
username = "holo";
in {
  imports =
    [
    ./nvim        
    ./starship
    ./scripts
    ./tmux
    ./git
    ./ssh
    ];
  home = {
    enableNixpkgsReleaseCheck = false;
    packages = with pkgs; [
      yazi 
        git
        lua-language-server
        fzf
        nil
        starship
    ] ++ [timr.packages.${system}.timr];
    sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
    };
    username = username;
  # This needs to actually be set to your username
    homeDirectory = "/home/${username}";

  # You do not need to change this if you're reading this in the future. Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
