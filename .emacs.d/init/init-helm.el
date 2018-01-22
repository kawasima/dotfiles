;;; init-helm.el --- Configuration for helm

;;; Commentary:
;;; Code:
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x b" . helm-mini)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ("C-c y" . helm-show-kill-ring)
         ("C-c m" . helm-man-woman)
         ("C-c o" . helm-occur)
         :map helm-map
         ("C-h" . delete-backward-char)
         :map helm-find-files-map
         ("C-h" . delete-backward-char)
         :map helm-read-file-map
         ("TAB" . helm-execute-persistent-action)
         :map helm-find-files-map
         ("TAB" . helm-execute-persistent-action))
  :config
  (progn
    (setq helm-bufferes-fuzzy-matching t)
    (helm-mode 1)))

(use-package helm-flx
  :ensure t
  :config
  (helm-flx-mode +1)
  (setq helm-flx-for-helm-find-files t))

(use-package helm-descbinds
  :ensure t
  :config
  (helm-descbinds-mode))

(provide 'init-helm)
;;; init-helm.el ends here
