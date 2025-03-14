{ config, lib, pkgs, ... }:

{ 
	imports = [
		./hardware-configuration.nix
	];
	
	# NETWORKING
	networking = {
		hostName = "Sondheim";
		
		networkmanager = {
			enable = true;
			wifi.backend = "iwd";
		};
	};
	
	# LOCALE
	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = { 
			"en_US.UTF-8";
		};
	};
	
	# TIME AND DATE
	time.timeZone = "America/Denver";
	
	# SYSTEM
	system = {
		stateVersion = "24.11";
		copySystemConfiguration = true;
		
		autoUpgrade = {
			enable = true;
			dates = "03:00";
			allowReboot = false;
		};
	};
	
	# HARDWARE
	hardware = {
		bluetooth.enable = true;
		
		graphics = {
			enable = true;
			enable32Bit = true;
		};
	};
	
	# BOOT
	boot = {
		## BOOT LOADER
		loader = {
			grub = {
				enable = true;
				device = "nodev";
				efiSupport = true;
				gfxmodeEfi = "1280x720";
				gfxpayloadEfi = "keep";
				useOSProber = true;
			};
			
			efi.canTouchEfiVariable = true;
		};
	};
	
	# SERVICES
	services = {
		seatd.enable = true;
		dbus.enable = true;
		
		thermald.enable = true;
		tlp.enable = true;
		fstrim.enable = true;
		udisks2.enable = true;
		
		## DISPLAY MANAGER
		displayManager = {
			defaultSession = "hyprland";
			
			### SDDM
			sddm = {
				enable = true;
				wayland.enable = true;
			};
		};
		
		## PIPEWIRE SOUND
		pipewire = {
			enable = true;
			alsa.enable = true;
		};
	};
	
	# USERS
	user.users.nathan = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
	};
	
	# XDG
	xdg = {
		portal.wlr.enable = true;
		portal.extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
	};
	
	# ENVIRONMENT
	## PACKAGES
	environment.systemPackages = with pkgs; [
		aquamarine
		bluez-alsa btop btrfs-progs
		curl
		dbus
		git go
		htop hyprpolkitagent hypridle hyprlock hyprpaper hyprpicker hyprcursor hyprutils hyprlang hyprgraphics hyprland-qtutils hyprland-qt-support hyprwayland-scanner hyprutils hyprsunset
		iwd
		kitty
		neofetch
		pavucontrol
		rustup
		seatd
		waybar wget wofi
	];
	
	# PROGRAMS
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
}
