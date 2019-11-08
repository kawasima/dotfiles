;;; init-golang.el --- Go mode

;;; Commentary:

;;; Code:

(use-package go-mode
  :ensure t
  :mode (("\\.go$" . go-mode))
  :config
  (add-hook 'go-mode-hook (lambda () (setq tab-width 4))))

(use-package company-go
  :ensure t
  :after  go)

(provide 'init-golang)
;;; init-golang.el ends here
