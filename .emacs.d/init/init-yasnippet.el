;;; yasnippet
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :bind (:map yas-minor-mode-map
	      ("C-x i i" . yas-insert-snippet)
	      ("C-x i n" . yas-new-snnipet)
	      ("C-x i v" . yas-visit-snnipet-file)
	      ("C-x i l" . yas-describe-tables)
	      ("C-x i g" . yas-reload-all))
  :config (yas-global-mode 1)
  (setq yas-prompt-functions '(yas-ido-prompt)))

(provide 'init-yasnippet)

