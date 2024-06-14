(use-modules
 (gnu)
 (nongnu system linux-initrd)
 (nongnu packages linux)
 (nongnu packages firmware)
 (guix packages))
(use-service-modules
 networking
 ssh
 desktop
 xorg
 dbus)
(use-package-modules
 wm
 shells
 bootloaders)

(operating-system
 (locale "zh_CN.utf8")
 (timezone "America/Los_Angeles")
 (keyboard-layout (keyboard-layout "us"))
 (host-name "poopcomputer")
 (kernel linux)
 (kernel-arguments '("module_blacklist=nouveau"))
 (initrd microcode-initrd)
 (firmware (list linux-firmware sof-firmware))
 (users
  (cons*
   (user-account
    (name "pooman123")
    (comment "Pooman123")
    (group "users")
    (shell (file-append fish "/bin/fish"))
    (home-directory "/home/pooman123")
    (supplementary-groups '("wheel" "netdev" "kvm")))
   %base-user-accounts))
 (groups %base-groups)
 (packages
  (append
   (map specification->package
	'("kakoune" "ncurses"))
   (filter
    (lambda (x)
      (not
       (member
	x
	(map specification->package
	     '("nano" "nvi" "mg" "inetutils")))))
    %base-packages)))
 (services
  (append (list
	   (service openssh-service-type)
	   (service accountsservice-service-type)
	   (service polkit-service-type)
	   (service elogind-service-type)
	   (service dbus-root-service-type)
	   (service upower-service-type)
	   (service udisks-service-type)
	   (service network-manager-service-type)
	   (service wpa-supplicant-service-type)
	   (service ntp-service-type)
	   (service
	    screen-locker-service-type
	    (screen-locker-configuration
	     (name "swaylock")
	     (program (file-append swaylock "/bin/swaylock"))
	     (using-pam? #t)
	     (using-setuid? #f))))
	  (modify-services
	   %base-services
	   (delete console-font-service-type)
	   (guix-service-type
	    config =>
	    (guix-configuration
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
 (file-systems
  (cons*
   (file-system
    (mount-point "/")
    (device (uuid
	     "9a768366-aee4-4ad9-9f8a-b477efe016c7"
	     'btrfs))
    (options "compress=zstd")
    (check? #t)
    (type "btrfs"))
   (file-system
    (mount-point "/swap")
    (device (uuid
	     "9a768366-aee4-4ad9-9f8a-b477efe016c7"
	     'btrfs))
    (options "subvol=swap")
    (type "btrfs"))
   (file-system
    (mount-point "/boot/efi")
    (device (uuid "1E64-CCC7"
		  'fat32))
    (check? #t)
    (type "vfat")) 
   (file-system
    (mount-point "/tmp")
    (device "none")
    (type "tmpfs")
    (check? #f)
    (flags '(no-suid no-dev)))
   %base-file-systems))
 (swap-devices
  (list
   (swap-space
    (target "/swap/swapfile")
    (dependencies (filter (file-system-mount-point-predicate "/swap")
			  file-systems))))))
