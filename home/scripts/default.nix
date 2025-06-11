{ config, pkgs, ... }:
let
  tmuxSessionizer = import ./tmux-sessionizer.nix { inherit pkgs; };
in
{
  home.packages = [ tmuxSessionizer ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      ${builtins.readFile ./yazi.sh}
      bind -x '"\C-f":"sessionizer"'
      eval "$(starship init bash)"
    '';
  };
}
