(use-modules
  (gnu)
  (gnu services base)
  (gnu services desktop)
  (nongnu system linux-initrd)
  (nongnu packages linux)
  (nongnu packages firmware))
(use-service-modules desktop networking ssh xorg dbus sound)
(use-package-modules
  vim
  wm
  freedesktop
  shells
  ncurses
  xdisorg
  terminals
  linux
  bootloaders
  polkit
  certs
  admin
  fonts)

(operating-system
  (locale "zh_CN.utf8")
  (timezone "Asia/Shanghai")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "poopcomputer")
  (kernel linux)
  (kernel-arguments '())
  (initrd microcode-initrd)
  (firmware (list linux-firmware sof-firmware))
  (users (cons* (user-account
		  (name "pooman123")
		  (comment "Pooman123")
		  (group "users")
		  (shell (file-append fish "/bin/fish"))
		  (home-directory "/home/pooman123")
		  (supplementary-groups '("wheel" "netdev" "audio" "video" "kvm")))
		%base-user-accounts))
  (packages (append (list nss-certs
			  neovim
			  fish
			  ncurses)
		    (filter 
		      (lambda (x) 
			(cond ((member x 
				       (map specification->package
					    '("nano" "nvi" "mg"))) '#f) 
			      (else '#t))) 
		      %base-packages)))
  (services
    (append (list
	      (service openssh-service-type)
	      (service upower-service-type)
	      (service accountsservice-service-type)
	      (service polkit-service-type)
	      (service elogind-service-type)
	      (service dbus-root-service-type)

	      (service alsa-service-type)

	      (service network-manager-service-type)
	      (service wpa-supplicant-service-type)
	      (service ntp-service-type)

	      (service screen-locker-service-type
		       (screen-locker-configuration
			 (name "swaylock")
			 (program (file-append swaylock "/bin/swaylock"))
			 (using-pam? #t)
			 (using-setuid? #f))))
	    (modify-services %base-services
			     (delete console-font-service-type)
			     (guix-service-type config => (guix-configuration
							    (inherit config)
							    (substitute-urls
							      (append (list "https://substitutes.nonguix.org")
								      %default-substitute-urls))
							    (authorized-keys
							      (append (list (local-file "./signing-key.pub"))
								      %default-authorized-guix-keys)))))))

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
			 (options "compress=zstd")
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
