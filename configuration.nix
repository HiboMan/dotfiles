# Edit this file to configure your system.
# Help is available in configuration.nix(5) man page & in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Boot.
  boot.initrd.luks.devices."luks-5b026fe9-087b-4f0d-91bd-e2725d2a95af".device = "/dev/disk/by-uuid/5b026fe9-087b-4f0d-91bd-e2725d2a95af";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    extraEntriesBeforeNixOS = true;
    useOSProber = true;
    efiSupport = true;
  };

  # Network, Time & Locale Settings
  networking = {
   hostName = "nixos";
   networkmanager.enable = true;
  };

  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Graphical Settings & Firmware & Steam Hardware Support
  hardware = {
    enableRedistributableFirmware = true;
    steam-hardware.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
    };
  };

  # Wayland, Keyboard layouts, Display Managers & Desktop Environments
  services = {
    fstrim.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    printing.enable = true;
    xserver.videoDrivers = ["nvidia"];
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  console.keyMap = "dk";

  # User & Apps Configuration
  users.users.hiboman = {
    isNormalUser = true;
    description = "hiboman";
    shell = pkgs.bash;
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      filen-desktop
      prismlauncher
      onlyoffice-bin
      okteta
      metadata-cleaner
      flameshot
      brave
      fastfetch
      unzip
      wget
      jetbrains.rust-rover
      vscodium
      obsidian
      audacity
      krita
      gparted
      filezilla
      obs-studio
      sparrow
      timeshift
      tor-browser
      keepassxc
      github-desktop
      signal-desktop
      thunderbird
      discord
      discordchatexporter-cli
      telegram-desktop
      pidgin
      pidginPackages.pidgin-otr
      putty
      gimp
      qbittorrent
      vlc
      anydesk
      wine
      heroic
    ];
  };

  programs = {
    firefox.enable = true;
    git.enable = true;
    nix-ld.enable = true;
    nh.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  # Virtualisation
  virtualisation.docker.enable = true;

  # NixOS Settings
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
     #sessionVariables = {
       #WLR_NO_HARDWARE_CURSORS = "1";
       #NIXOS_OZONE_WL = "1";
     #};
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
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
  system.stateVersion = "24.11"; # Did you read the comment?

}
