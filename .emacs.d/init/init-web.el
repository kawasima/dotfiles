;;; init-web.el --- Configuration of web-mode

;;; Commentary:

;;; Code:

(use-package web-mode
  :ensure t
  :mode (("\\.html\\'" . web-mode)
         ("\\.ftl\\'"  . web-mode)
         ("\\.tsx\\'"  . web-mode))
  :init (progn
          (setq web-mode-enable-auto-pairing nil)
          (setq web-mode-attr-indent-offset nil)
          (setq web-mode-css-indent-offset 2)
          (setq web-mode-code-indent-offset 2)
          (setq web-mode-sql-indent-offset 2)
          (setq indent-tabs-mode nil)
          (setq tab-width 2)))

(provide 'init-web)
;;; init-web.el ends here
