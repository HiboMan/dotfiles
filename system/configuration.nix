# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  ...
}: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c3ea31d3-4a4e-47db-996c-8f02ef999cd0".device = "/dev/disk/by-uuid/c3ea31d3-4a4e-47db-996c-8f02ef999cd0";
  
   networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.dhcp = "dhcpcd";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    enableRedistributableFirmware = true;
    steam-hardware.enable = true;

    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = pkgs.linuxPackages.nvidiaPackages.stable;
    };
  };

  # Define Services
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
    };

    fstrim.enable = true;
    flatpak.enable = true;
    openssh.enable = true;

    xserver = {
      videoDrivers = ["nvidia"];
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  console.keyMap = "dk";

  users.users.hiboman = {
    isNormalUser = true;
    description = "hiboman";
    shell = pkgs.bash;
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      flameshot
      dhcpcd
      brave
      fastfetch
      unzip
      wget
      discord
      vscodium
      obsidian
      audacity
      # minecraft
      krita
      gparted
      filezilla
      obs-studio
      sparrow
      # exodus
      timeshift
      tor-browser
      keepassxc
      trezord
      github-desktop
      thunderbird
      element-desktop
      putty
      gimp
      qbittorrent
      vlc
      anydesk
      wine
      heroic
      # bless-hex-editor
      # discordchatexporter-desktop
      # onlyoffice-desktopeditors
      signal-desktop
      pidgin
      pidginPackages.pidgin-otr
    ];
  };

  programs = {
    firefox.enable = true;
    steam.enable = true;
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
      LC_ALL = "en_US.UTF-8";
    };
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users."hiboman" = import ./home.nix;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  ];

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
