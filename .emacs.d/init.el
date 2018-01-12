
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
    ("2022c5a92bbc261e045ec053aa466705999863f14b84c012a43f55a95bf9feb8" default)))
 '(global-linum-mode t)
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (haml-mode cider clojure-mode paredit yasnippet js2-mode zenburn-theme use-package typing twittering-mode rainbow-delimiters markdown-mode magit lfe-mode helm haskell-mode go-mode dockerfile-mode company-statistics coffee-mode clojurescript-mode clj-refactor ac-cider)))
 '(yas-trigger-key "TAB"))
(setq linum-format "%4d\u2502")
(set-face-attribute 'linum nil
  :foreground "#4a4"
  :height 1.0)
(line-number-mode t)
(column-number-mode t)

;; Package
(require 'init-package)
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

;;; paren mode
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match-face nil
  :background "gray10" :foreground "SkyBlue"
  :underline nil)

;;; Buffer name
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'init-helm)


;;; Minor mode
;;;
(require 'init-flymake)
(require 'init-autocomplete)
(require 'init-yasnippet)
(require 'init-paredit)
;(require 'magit)

;;;
;;; Major mode
;;;
(require 'init-javascript)
(require 'init-ruby)
(require 'init-clojure)
;(require 'init-java)
(require 'init-haml)
(require 'init-markdown)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
