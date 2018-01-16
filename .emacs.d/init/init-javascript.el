(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-jsx-mode))
  :init
  (setq js2-highlight-level 3
        js2-mode-show-parse-errors nil
        js2-strict-missing-semi-warning nil
        js2-strict-trailing-comma-warning nil
        js2-mode-assume-strict t
        js2-missing-semi-one-line-override nil
        js2-basic-offset 2))

(provide 'init-javascript)
