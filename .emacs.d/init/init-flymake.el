(use-package flycheck
  :ensure t
  :init
  (progn
    (global-flycheck-mode)
    (flycheck-add-mode 'javascript-eslint 'js2-mode))
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-highlighting-mode 'lines))

(use-package flymake :disabled t)

(provide 'init-flymake)
