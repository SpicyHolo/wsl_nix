
{ config, pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;

    # WSL Compatible
    secureSocket = false;
  
    plugins = with pkgs; 
      [
        { 
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g status-left ""
            set -g status-right "#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S "
            set -g @catppuccin_window_text " #W"
            set -g @catppuccin_window_current_text " #W"
          '';
        }
      ];
    extraConfig = ''
      # Basic options
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"
      set -g mouse on
      set -g status-position top

      # Change prefix
      set -g prefix C-a
      bind-key C-a send-prefix
      
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R
    '';
  };
}
