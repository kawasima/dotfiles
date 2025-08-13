;;; init.el --- Emacs configuration

;;; Commentary:
;; Main Emacs configuration file
;; Loads custom.el for custom variables and specific configuration modules

;;; Code:

;;;; Load Path Setup
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/init")

;;;; Load Custom Variables
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;;;; Proxy Configuration
(condition-case nil
    (load "init-proxy" t)
  (error (message "Warning: init-proxy not found")))

;;;; UI Configuration
(display-time)
(column-number-mode t)

;; Conditional UI elements based on display type
(when (display-graphic-p)
  (tool-bar-mode -1))
(unless (display-graphic-p)
  (menu-bar-mode -1))

;;;; Package System
(condition-case nil
    (require 'init-package)
  (error (message "Error: init-package not found")))

;;;; Essential Packages
(use-package no-littering :ensure t)

;;;; Input Method
(condition-case nil
    (require 'init-mozc)
  (error (message "Warning: init-mozc not found")))

;;;; Theme
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;;;; Platform-specific Configuration
(when (eq system-type 'windows-nt)
  (condition-case nil
      (require 'init-w32)
    (error (message "Warning: init-w32 not found"))))

;;;; Core Editor Settings
;; File handling
(setq auto-compression-mode t
      make-backup-files nil
      vc-follow-symlinks t)

;; Editing behavior
(setq-default indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Auto-revert files when changed externally
(global-auto-revert-mode 1)

;; Key bindings
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;;;; Built-in Enhancements
;; Line numbers for programming
(use-package display-line-numbers
  :hook ((prog-mode text-mode) . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type t
        display-line-numbers-width-start t)
  (set-face-attribute 'line-number nil :height 0.9)
  (set-face-attribute 'line-number-current-line nil :height 0.9))

;; Recent files
(use-package recentf
  :config
  (setq recentf-max-saved-items 1000
        recentf-max-menu-items 15
        recentf-auto-cleanup 'never
        recentf-exclude '("/tmp/" "/ssh:" "/sudo:"))
  (recentf-mode +1))

;; Session management
(use-package savehist
  :config
  (setq savehist-additional-variables '(search-ring regexp-search-ring))
  (savehist-mode 1))

(use-package saveplace
  :config
  (save-place-mode 1))

;; Parentheses matching
(show-paren-mode t)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match nil
  :background "gray10" :foreground "SkyBlue"
  :underline nil)

;; Buffer naming
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Smooth scrolling (Emacs 29+)
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

;;;; Utility Packages
(use-package speed-type :ensure t :defer t)

;;;; UI Enhancement Modules
(condition-case nil
    (require 'init-diminish)
  (error (message "Warning: init-diminish not found")))

(condition-case nil
    (require 'init-neotree)
  (error (message "Warning: init-neotree not found")))

(condition-case nil
    (require 'init-helm)
  (error (message "Warning: init-helm not found")))

(condition-case nil
    (require 'init-presentation)
  (error (message "Warning: init-presentation not found")))

;;;; Major Mode Configurations
(condition-case nil (require 'init-web) (error nil))
(condition-case nil (require 'init-javascript) (error nil))
(condition-case nil (require 'init-java) (error nil))
(condition-case nil (require 'init-ruby) (error nil))
(condition-case nil (require 'init-clojure) (error nil))
(condition-case nil (require 'init-golang) (error nil))
(condition-case nil (require 'init-rust) (error nil))
(condition-case nil (require 'init-elm) (error nil))
(condition-case nil (require 'init-fsharp) (error nil))
(condition-case nil (require 'init-groovy) (error nil))
(condition-case nil (require 'init-haml) (error nil))
(condition-case nil (require 'init-markdown) (error nil))
(condition-case nil (require 'init-org) (error nil))
(condition-case nil (require 'init-docker) (error nil))

;; YAML mode
(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")

;;;; Minor Mode Configurations
(condition-case nil (require 'init-lsp) (error nil))
(condition-case nil (require 'init-flymake) (error nil))
(condition-case nil (require 'init-autocomplete) (error nil))
(condition-case nil (require 'init-yasnippet) (error nil))
(condition-case nil (require 'init-paredit) (error nil))
;;;; Additional Packages
;; Compatibility layer for packages
(use-package compat
  :ensure t
  :demand t)

;; Image enhancement
(use-package image+
  :ensure t
  :after image-mode
  :init (add-hook 'image-mode-hook (lambda () (require 'image+)))
  :config (bind-keys :map image-mode-map
             ("0" . imagex-sticky-restore-original)
             ("+" . imagex-sticky-maximize)
             ("=" . imagex-sticky-zoom-in)
             ("-" . imagex-sticky-zoom-out)))

;; Claude Code integration
(use-package claude-code
  :ensure t
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

;; Terraform support
(use-package terraform-mode
  :ensure t
  :mode "\\.tf\\'")

;;;; Key Bindings
(bind-key "<next>" #'scroll-up-line)
(bind-key "<prior>" #'scroll-down-line)

;;; init.el ends here
