{ pkgs }:

pkgs.writeShellApplication {
  name = "sessionizer";
  runtimeInputs = [ pkgs.fzf pkgs.tmux ];
  text = ''
    if [[ $# -eq 1 ]]; then
      selected=$1
    else
      selected=$(find ~/projects -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
      exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)

    # session exists
    if tmux has-session -t "$selected_name" 2>/dev/null; then
      # in tmusx, so just switch to it
      if [ "''${TERM_PROGRAM:-}" == "tmux" ]; then
        tmux switch-client -t "$selected_name"
      else # not in tmux
        tmux attach-session -t "$selected_name"
      fi
    else # session doesn't exist.
      if [ "''${TERM_PROGRAM:-}" == "tmux" ]; then
        tmux new-session -ds "$selected_name" -c "$selected"
        tmux switch-client -t "$selected_name"
      else # not in tmux
        tmux new-session -s "$selected_name" -c "$selected"
      fi

      # Run nix flake if it exists, and if session was just created
      if [ -f "$selected/flake.nix" ]; then
        echo "Flake located."
        tmux send-keys -t "$selected_name:1" "nix develop" C-m
      fi
    fi

    # Run nix develop if exists
  '';
}
