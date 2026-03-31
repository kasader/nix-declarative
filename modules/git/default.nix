{
  programs = {

    git = {
	  	enable = true;
      settings.user = {
	      name = "kasader";
	  	  email = "casada980@gmail.com";
      };
    };

    # TODO: Make sure to move to dedicated file.
    delta = {
      enable = true;
      enableGitIntegration = true;
    };

	};
}
