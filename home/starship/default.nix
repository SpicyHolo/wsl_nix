{lib, config, pkgs, ...}:
{
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "[](fg:mauve)$os[](fg:mauve) "
        "$directory "
        "$git_branch "
        "$git_status "
        "$fill$nix_shell$golang$nodejs$python$java$c$cpp$time$username"
        "$line_break $character"
      ];

      palette = "catpuccin_latte";
      palettes.catpuccin_latte = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#d20f39";
        maroon = "#e64553";
        peach = "#fab387";
        yellow = "#f9e2af";
        een = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };

      os = {
        format = "[󰌽 WSL]($style)";
        style = "bg:mauve fg:base";
        disabled = false;
      };

      directory = {
        format = "[$read_only$truncation_symbol$path]($style)";
        home_symbol = "~";
        truncation_symbol = "";
        truncation_length = 3;
        read_only = "";
        read_only_style = "";
        style = "bold peach";
      };

      git_branch = {
        symbol = " ";
        format = "[on](fg:text) [$symbol$branch]($style)";
        style = "bold maroon";
      };

      git_status = {
        style = "bold red";
      };

      fill = {
        symbol = " ";
      };

      nix_shell = {
        format = " [](fg:blue)[$symbol](fg:base bg:blue)[](fg:blue)";
        symbol = " $name";

      };
      nodejs = {
        format = " [](fg:green)[$symbol](fg:base bg:green)[ $version](fg:base bg:green)[](fg:green)";
        symbol = "󰎙 Node.js";
      };

      python = {
        format = " [](fg:green)[$symbol](fg:base bg:green)[ (\${version} )(\\($virtualenv\\) )](fg:base bg:green)[](fg:green)";
        symbol = " python";
      };

      java = {
        format = " [](fg:red)[$symbol](fg:base bg:red)[ $version](fg:base bg:red)[](fg:red)";
        symbol = " Java";
      };

      golang = {
        format = " [](fg:red)[$symbol](fg:base bg:red)[ $version](fg:base bg:red)[](fg:red)";
        symbol = "󰟓 Go";
      };

      c = {
        format = " [](fg:maroon)[$symbol](fg:base bg:maroon)[ $version](fg:base bg:maroon)[](fg:maroon)";
        symbol = " C";
      };

      cpp = {
        format = " [](fg:red)[$symbol](fg:base bg:red)[ $version](fg:base bg:red)[](fg:red)";
        symbol = " C++";
        disabled = false;
      };

      cmd_duration = {
        min_time = 500;
        format = " [](fg:peach)[](fg:base bg:peach)[ $duration](fg:base bg:peach)[](fg:peach)";
      };

      time = {
        format = " [](fg:mauve)[󰦖 ](fg:base bg:mauve)[$time](fg:base bg:mauve)[](fg:mauve)";
        time_format = "%H:%M | %a, %d %B";
        disabled = false;
      };

      username = {
        format = " [](fg:yellow)[ ](fg:base bg:yellow)[$user](fg:base bg:yellow)[](fg:yellow) ";
        show_always = true;
      };

      character = {
        format = ''
          [$symbol](fg:current_line) '';
        success_symbol = "[](fg:bold white)";
        error_symbol = "[×](fg:bold red)";
      };

      profiles = {
        transient = "$character";
      };
    };
  };

}


