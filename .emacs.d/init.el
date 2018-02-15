;;; init.el --- Emacs configuration

;;; Commentary:
;;; Code:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/init")
(load "init-proxy" t)

(display-time)
(tool-bar-mode 0)
(unless (window-system)
  (menu-bar-mode 0))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "2022c5a92bbc261e045ec053aa466705999863f14b84c012a43f55a95bf9feb8" default)))
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (speed-type image+ web-mode neotree diminish ace-window helm-descbinds helm-flx helm-config haml-mode cider clojure-mode paredit yasnippet js2-mode zenburn-theme use-package typing twittering-mode rainbow-delimiters markdown-mode magit lfe-mode helm haskell-mode go-mode dockerfile-mode company-statistics coffee-mode clojurescript-mode clj-refactor ac-cider)))
 '(yas-trigger-key "TAB"))

;; Package
(require 'init-package)

(use-package no-littering :ensure t)
(use-package linum-off :ensure t)
(use-package nlinum :ensure t :after linum-off
  :config
  (advice-add 'nlinum-mode :around
              (lambda (orig-f &rest args)
                (unless (or (minibufferp)
                            (or
                             (eq major-mode 'treemacs-mode)
                             (memq major-mode linum-disabled-modes-list))
                            (string-match "*" (buffer-name)))
                  (apply orig-f args))))
  (custom-set-faces '(linum ((t :height 0.9))))
  (global-nlinum-mode))

(column-number-mode t)

(require 'init-locales)
(require 'init-mozc)

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn))

(when (eq window-system 'w32)
  (require 'init-w32))

;; Hide startup message
(setq inhibit-startup-message t)

;; Enable to read compressed files.
(auto-compression-mode t)

;; Ctrl+H
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; Delete trailing whitespaces before a file will be saved.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; No backup file
(setq make-backup-files nil)

;;; Indent settings
(setq-default indent-tabs-mode nil)

;; yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; follow symlinks
(setq vc-follow-symlinks t)

;; Reload updated file automatically
(global-auto-revert-mode 1)

;;; Recentf
(use-package recentf
  :config
  (setq recentf-max-saved-items 1000
        recentf-max-menu-items 15
        recentf-auto-cleanup 'never)
  (recentf-mode +1))

;;; paren mode
(show-paren-mode t)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match-face nil
  :background "gray10" :foreground "SkyBlue"
  :underline nil)

;;;
(use-package speed-type :ensure t)

;;; Buffer name
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'init-diminish)
(require 'init-neotree)
(require 'init-helm)


;;;
;;; Major mode
;;;
(require 'init-web)
(require 'init-javascript)
(require 'init-ruby)
(require 'init-clojure)
;(require 'init-java)
(require 'init-haml)
(require 'init-markdown)
(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")
(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

;;; Minor mode
;;;
(require 'init-flymake)
(require 'init-autocomplete)
(require 'init-yasnippet)
(require 'init-paredit)
(use-package magit
  :ensure t)

;;; Image
(use-package image+
  :ensure t
  :after 'image-mode
  :init (add-hook 'image-mode-hook '(lambda () (require 'image+)))
  :config (bind-keys :map image-mode-map
             ("0" . imagex-sticky-restore-original)
             ("+" . imagex-sticky-maximize)
             ("=" . imagex-sticky-zoom-in)
             ("-" . imagex-sticky-zoom-out)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t :height 0.9))))
;;; init.el ends here
