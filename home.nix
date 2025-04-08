{pkgs, ...}: {
  home.username = "hiboman";
  home.homeDirectory = "/home/hiboman";
  home.stateVersion = "24.05";

  programs = {
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "nano";
  };
}
