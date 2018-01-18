;;; init-web.el --- Configuration of web-mode

;;; Commentary:

;;; Code:

(use-package web-mode
  :ensure t
  :mode (("\\.html\\'" . web-mode)
         ("\\.ftl\\'" . web-mode))
  :init (progn
          (setq web-mode-enable-auto-pairing nil)))

(provide 'init-web)
;;; init-web.el ends here
