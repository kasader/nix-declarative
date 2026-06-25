{ pkgs, ... }:
{
  programs = {

    git = {
      enable = true;
      lfs.enable = true;
      settings.user = {
        name = "kasader";
	email = "casada980@gmail.com";
      };
      settings.url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
      settings.push.default = "current";
      ignores = [
        ".DS_Store"
        "*~"
        "**/.claude/settings.local.json"
      ];
    };

    # TODO: Make sure to move to dedicated file.
    delta = {
      enable = true;
      enableGitIntegration = true;
    };

	};

  home.packages = with pkgs; [
    git-filter-repo
    gitlint
  ];
}
