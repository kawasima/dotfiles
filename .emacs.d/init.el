;; Load path

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/init")

(display-time)
(tool-bar-mode 0)
(unless (window-system)
  (menu-bar-mode 0))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "7b0433e99dad500efbdf57cf74553499cde4faf2908a2852850c04b216c41cc9" "76c373255695afe7f69263a9fb0ab392d8bc07644a9bc21021bc82117c7b17ae" default)))
 '(global-linum-mode t)
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (js2-mode zenburn-theme use-package typing twittering-mode rainbow-delimiters markdown-mode magit lfe-mode helm haskell-mode go-mode dockerfile-mode company-statistics coffee-mode clojurescript-mode clj-refactor ac-cider)))
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

(load-theme 'zenburn t)

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
(require 'init-java)
(require 'init-haml)
(require 'init-markdown)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
