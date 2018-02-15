(use-package markdown-mode
  :ensure t
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :init (setq markdown-command "marked"))

(provide 'init-markdown)
