;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (gnu services desktop)
	     (nongnu system linux-initrd)
	     (nongnu packages linux)
	     (nongnu packages firmware))
(use-service-modules desktop networking ssh xorg dbus sound)
(use-package-modules vim
		     wm
		     freedesktop
		     shells
		     ncurses
		     xdisorg
		     terminals
		     linux
		     bootloaders
		     polkit)

(operating-system
  (locale "zh_CN.utf8")
  (timezone "Asia/Shanghai")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "poopcomputer")
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware sof-firmware))
  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
		  (name "pooman123")
		  (comment "Pooman123")
		  (group "users")
		  (shell (file-append fish "/bin/fish"))
		  (home-directory "/home/pooman123")
		  (supplementary-groups '("wheel" "netdev" "audio" "video" "kvm")))
		%base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "nss-certs")
			  neovim
			  fish
			  ncurses)
		    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.

  (services
    (append (list
	      (service openssh-service-type))
	    (modify-services %desktop-services
			     (delete gdm-service-type)
			     ;; (delete network-manager-applet)
			     (delete pulseaudio-service-type)
			     (guix-service-type config => (guix-configuration
							    (inherit config)
							    (substitute-urls
							      (append (list "https://substitutes.nonguix.org")
								      %default-substitute-urls))
							    (authorized-keys
							      (append (list (local-file "./signing-key.pub"))
								      %default-authorized-guix-keys))))

			     ))

    )

  ;; other stuff =================================================

  (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(targets (list "/boot/efi"))
		(keyboard-layout keyboard-layout)))
  (initrd-modules (append '("vmd") %base-initrd-modules))
  ;;(kernel-arguments '("modprobe.blacklist=nouveau"))
  (swap-devices (list (swap-space
			(target (uuid
				  "2567c2db-e188-47fb-8159-e6d1b0e8106d")))))

  (file-systems (cons* (file-system
			 (mount-point "/")
			 (device (uuid
				   "459af246-2ef1-4dda-a268-7304f50e3633"
				   'btrfs))
			 (type "btrfs"))
		       (file-system
			 (mount-point "/boot/efi")
			 (device (uuid "6AC5-B302"
				       'fat32))
			 (type "vfat")) 
		       (file-system
			 (mount-point "/tmp")
			 (device "none")
			 (type "tmpfs")
			 (check? #f)
			 (flags '(no-suid no-dev)))
		       %base-file-systems)))
