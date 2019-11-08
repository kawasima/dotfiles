;;; Clojure mode
(use-package clojure-mode
  :ensure t
  :mode (("\\.edn$" . clojure-mode)
	 ("\\.cljs$" . clojurescript-mode)
	 ("\\.cljx$" . clojurex-mode)
	 ("\\.cljc$" . clojurec-mode))
  :init
  (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'clojure-mode-hook #'yas-minor-mode)
  (add-hook 'clojure-mode-hook #'subword-mode)
  (add-hook 'clojure-mode-hook #'clj-refactor-mode)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

  :config
  (progn
    (setq clojure-align-forms-automatically t)
    ;; indent
                                        ; core.async
    (put-clojure-indent 'go-loop 'defun)
    (put-clojure-indent 'go 'defun)

                                        ; om
    (put-clojure-indent 'render 'defun)
    (put-clojure-indent 'render-state 'defun)
    (put-clojure-indent 'will-mount 'defun)
    (put-clojure-indent 'did-mount 'defun)
    (put-clojure-indent 'will-unmount 'defun)
    (put-clojure-indent 'will-update 'defun)
    (put-clojure-indent 'did-update 'defun)
    (put-clojure-indent 'init-state 'defun)

                                        ; compojure
    (define-clojure-indent
      (defroutes 'defun)
      (GET 2)
      (POST 2)
      (PUT 2)
      (DELETE 2)
      (HEAD 2)
      (ANY 2)
      (context 2))))

;; CIDER
(use-package cider
  :ensure t
;;  :commands (cider-mode cider-jack-in)
  :init
  (add-hook 'cider-mode-hook #'clj-refactor-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  :diminish subword-mode
  :config
  (setq nrepl-log-messages nil
        cider-repl-pop-to-buffer-on-connect nil
        cider-repl-display-in-current-window t
        cider-repl-display-help-banner nil
        cider-repl-use-clojure-font-lock t
        cider-prompt-save-file-on-load 'always-save
        cider-font-lock-dynamically '(macro core function var)
        cider-overlays-use-font-lock t)
  (cider-repl-toggle-pretty-printing))

(provide 'init-clojure)
