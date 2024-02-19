(custom-set-variables
 '(custom-enabled-themes '(modus-vivendi))
 '(default-input-method "chinese-tonepy-punct")
 '(fido-vertical-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(mpc-songs-format "%-5{Time} %200{Title}")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(treesit-font-lock-level 4))
(setq auto-mode-alist
      (append '(("\\.rs\\'" . rust-ts-mode))
	      '(("\\.tsx\\'" . tsx-ts-mode))
	      '(("\\.ts\\'" . typescript-ts-mode))
	      '(("\\.yml\\'" . yaml-ts-mode))
              auto-mode-alist))
(setq major-mode-remap-alist
      '((sh-mode . bash-ts-mode)
	(js-json-mode . json-ts-mode)
	(javascript-mode . js-ts-mode)
	(python-mode . python-ts-mode)
	(conf-toml-mode . toml-ts-mode)
	(css-mode . css-ts-mode)
	(c-mode . c-ts-mode)
	(c++-mode . c++-ts-mode)
	(c-or-c++-mode . c-or-c++-ts-mode)))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	       '((rust-ts-mode) .
		 ("rust-analyzer"
		  :initializationOptions (:check (:command "clippy"))))))
(set-fontset-font t 'cjk-misc "Noto Sans CJK SC")
(set-fontset-font t 'han "Noto Sans CJK SC")
(set-fontset-font t 'kana "Noto Sans CJK JP")
(set-fontset-font t 'hangul "Noto Sans CJK KR")
