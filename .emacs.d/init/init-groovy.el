;;; Clojure mode
(use-package groovy-mode
  :ensure t
  :mode (("\\.gradle$" . groovy-mode)
	 ("\\.cljs$" . groovy-mode))
  :init
  (add-hook 'clojure-mode-hook #'paredit-mode))

(provide 'init-groovy)
