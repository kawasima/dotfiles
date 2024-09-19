;;; Rust mode
(use-package rust-mode
  :ensure t
  :mode (("\\.rs$" . rust-mode))
  :init
  (setq rust-format-on-save t))
(provide 'init-rust)
