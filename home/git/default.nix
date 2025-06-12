{ config, pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "SpicyHolo";
    userEmail = "41269364+SpicyHolo@users.noreply.github.com";

    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";

      color = {
        ui = "auto";
        status = "auto";
        branch = "auto";
        diff = "auto";
        interactive = "auto";
      };

      core = {
        editor = "nvim"; # or "vim", "helix", etc.
      };
    };
  };
}
