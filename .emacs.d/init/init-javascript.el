;;; init-javascript.el --- Configuration for javascript

;;; Commentary:
;;; Code:
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

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(use-package tide
  :ensure t
  :init  (setq tide-tsserver-executable "node_modules/typescript/bin/tsserver"
               typescript-indent-level 2)
  :mode  (("\\.ts\\'" . typescript-mode))
  :after (typescript-mode company flycheck)
  :hook  ((typescript-mode . tide-setup)
          (typescript-mode . tide-hl-identifier-mode)
          (before-save . tide-format-before-save)))

(use-package graphql-mode
  :ensure t)
(provide 'init-javascript)
;;; init-javascript.el ends here
