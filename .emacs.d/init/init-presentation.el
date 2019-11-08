;;; init-presentation.el --- Configuration for presentation

;;; Commentary:
;;; Code:

(use-package presentation
  :ensure t
  :init (setq presentation-default-text-scale 8)
  :config (setq scroll-conservatively 1)
  )

(provide 'init-presentation)
;;; init-presentation.el ends here
