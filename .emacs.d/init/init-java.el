;;; CEDET
(use-package cedet)
(global-ede-mode t)
(setq semantic-default-submodes
  '(global-semantic-ide-scheduler-mode
     global-semanticdb-minor-mode
     global-semantic-idle-summary-mode
     global-semantic-mru-bookmark-mode))
(semantic-mode t)

;;; malabar
(add-to-list 'load-path "/opt/malabar/lisp")  ;; malabar
(when (require 'malabar-mode nil t)
  (setq malabar-groovy-lib-dir "/opt/malabar/lib")
  (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode)))

(provide 'init-java)

