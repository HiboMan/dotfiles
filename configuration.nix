# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canBootFromEfi = true;
      timeout = 5;
      editor = true;
    };
    kernelParams = ["root=PARTUUID=${config.boot.loader.efi.partUuid}"];
    kernelModules = ["amd-ucode"];
  };

  networking = {
    hostName = "overlord"; # Define your hostname.
    networkmanager.enable = true; # Enable networking

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Define Services
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
    };
    flatpak.enable = true;

  console.keyMap = "dk";  # Replace 'us' with your desired layout

    # Enable the OpenSSH daemon.
    openssh.enable = true;
    #xserver = {
    #enable = true;
    #xkb = {
    #layout = "us";
    #variant = "";
    #};
    #};
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland = true;
    };
  };

  users.users.hiboman = {
    isNormalUser = true;
    description = "hiboman";
    shell = pkgs.bash;
    extraGroups = ["wheel" "power" "storage" "networkmanager" "docker"];
    packages = with pkgs; [
      fastfetch
     # inputs.zen-browser.packages."${system}".generic
      brave
      firefox
      unzip
    ];
  };

  programs = {
    bash.enable = true;
    git.enable = true;
    nix-ld.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Setting up Virtualization
  virtualisation.docker.enable = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [
     "docker-desktop"
  ];

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users."hiboman" = import ./home.nix;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      kate
      konsole
      discord
      docker-desktop
      wget
    ];
  };
  # List services that you want to enable:
  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
    polkit.enable = true;
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
