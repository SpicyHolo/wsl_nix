{ config, pkgs, ...}:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "SpicyHolo";
      user.mail = "41269364+SpicyHolo@users.noreply.github.com";
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
