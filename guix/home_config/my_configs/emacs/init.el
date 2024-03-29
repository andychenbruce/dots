(custom-set-variables
 '(custom-enabled-themes '(modus-operandi))
 '(default-input-method "chinese-tonepy-punct")
 '(current-language-environment "UTF-8")
 '(eldoc-echo-area-use-multiline-p nil)
 '(fido-vertical-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(mpc-songs-format "%-5{Time} %200{Title}")
 '(scroll-bar-mode nil)
 '(term-mode-hook '(lambda () (toggle-truncate-lines 1)))
 '(tool-bar-mode nil)
 '(treesit-font-lock-level 4))
(setq auto-mode-alist
      (append '(("\\.rs\\'" . rust-ts-mode))
	      '(("\\.tsx\\'" . tsx-ts-mode))
	      '(("\\.ts\\'" . typescript-ts-mode))
	      '(("\\.yml\\'" . yaml-ts-mode))
	      '(("\\CMakeLists.txt\\'" . cmake-ts-mode))
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
(add-hook 'eshell-mode-hook '(lambda ()
			       (setenv "TERM" "dumb-emacs-ansi")))
