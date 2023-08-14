;; What follows is a "manifest" equivalent to the command line you gave.
;; You can store it in a file that you may then pass to any 'guix' command
;; that accepts a '--manifest' (or '-m') option.

(specifications->manifest
  (list "bash"
	"findutils"
	"procps"
        "coreutils"
        "grep"
	"emacs-next-pgtk"
	"ncurses"
	"font-google-noto"
	"font-gnu-unifont"
	"adwaita-icon-theme"
	"gsettings-desktop-schemas"
	"glibc-locales"
	"intel-media-driver-nonfree"
	"libva-utils"))
