{ config, pkgs, ... }:
 
{
  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    wget neovim curl bash gnupg git jq sshpass xclip tmux most gitAndTools.gitflow p7zip htop bind
    gnumake openssl libffi gcc chrpath
    firefox vlc libreoffice-fresh keepass
    networkmanagerapplet networkmanager-openconnect networkmanager-openvpn
    docker docker_compose kubectl minikube kubernetes-helm ansible-lint terraform
    go dep
    nodejs
    pythonFull python27Packages.flake8 python27Packages.passlib
    ruby
    rustc cargo rustfmt
    elixir
  ];

  networking.networkmanager.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Luxembourg";

  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    enableCompletion = true;
    shellInit = "export PATH=\"$PATH:$HOME/go/bin/\"";
    shellAliases = {
      l = "ls -alh";
      ll = "ls -l";
      ls = "ls --color=tty";
      vim = "nvim";
    };
  };
  programs.ssh.startAgent = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Activate SSH
  #networking.firewall.allowedTCPPorts = [ 22 ];
  #services.openssh.enable = true;
  networking.firewall.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.bluetooth.enable = true;

  services.acpid.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.gutenprintBin pkgs.samsungUnifiedLinuxDriver ];

  virtualisation.docker.enable = true;
  #virtualisation.docker.liveRestore = false;

  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableHardening = false;
  
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    #xkbOptions = "eurosign:e";

    libinput.enable = true;
    desktopManager.gnome3.enable = true;
    displayManager.gdm.enable = true;
  };

  users = {
    mutableUsers = true;
    extraUsers = {
      root.initialHashedPassword = "$6$sr21zHSb24V$pv7yS8GGMry9nxZabscKW04qOnPWQ4aeuI7gjyFnlewdXg.nwDWkffaYP5QDXB7cKhSAd1AY9FYTXTEr63q0T0";

      bordel = {
        isNormalUser = true;
        group = "users";
        extraGroups = [ "wheel" "disk" "audio" "video" "sudo" "networkmanager" "docker" "vboxusers" ];
        home = "/home/bordel";
        hashedPassword = "$6$anRsrtFL3LC3E$d6Dh4PVx3vIcgA89vgzpD4YpabnuoNesSjhEPpPVFWqn97ySSlWU8KMo1e3ZdTVCt4hXFE9S7OSNZDpPFiZRx.";
        uid = 1000;
      };
    };

  };

  security.sudo.enable = true;
}
