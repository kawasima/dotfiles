(use-package flycheck
  :ensure t
  :init
  (progn
    (global-flycheck-mode)
    (flycheck-add-mode 'javascript-eslint 'js2-mode))
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-highlighting-mode 'lines))

(use-package flycheck-rust
  :ensure t
  :config
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(use-package flymake :disabled t)

(provide 'init-flymake)
