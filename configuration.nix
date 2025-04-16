# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-5b026fe9-087b-4f0d-91bd-e2725d2a95af".device = "/dev/disk/by-uuid/5b026fe9-087b-4f0d-91bd-e2725d2a95af";

   networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
    steam-hardware.enable = true;

    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Define Services
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };

    fstrim.enable = true;
    flatpak.enable = true;
    openssh.enable = true;

    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

    xserver.videoDriver = "nvidia";
  };

  console.keyMap = "dk";

  users.users.hiboman = {
    isNormalUser = true;
    description = "hiboman";
    shell = pkgs.bash;
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      prismlauncher
      discordchatexporter-cli
      onlyoffice-bin
      okteta
      metadata-cleaner
      flameshot
      brave
      fastfetch
      unzip
      wget
      discord
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
      thunderbird
      element-desktop
      putty
      gimp
      qbittorrent
      vlc
      anydesk
      wine
      heroic
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #environment.variables = {
    #LIBVA_DRIVER_NAME="nvidia";
    #XDG_SESSION_TYPE = "wayland";
    #GBM_BACKEND = "nvidia-drm";
    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  #};

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
