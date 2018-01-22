;;; init-paredit.el --- Configuration of paredit

;;; Commentary:
;;; Code:
(use-package paredit
  :ensure t
  :diminish paredit-mode
  :init
  (progn
    (add-hook 'clojure-mode-hook 'enable-paredit-mode)
    (add-hook 'cider-repl-mode-hook 'enable-paredit-mode)
    (add-hook 'lisp-mode-hook 'enable-paredit-mode)
    (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
    (add-hook 'json-mode-hook 'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)))

(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

(provide 'init-paredit)
;;; init-paredit.el ends here
