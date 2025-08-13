;;; init-lsp.el --- LSP Mode Configuration -*- lexical-binding: t -*-

;;; Commentary:
;; Language Server Protocol support using lsp-mode

;;; Code:

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((typescript-mode . lsp-deferred)
         (javascript-mode . lsp-deferred)
         (js2-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (css-mode . lsp-deferred)
         (python-mode . lsp-deferred)
         (java-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         (rust-mode . lsp-deferred)
         (ruby-mode . lsp-deferred)
         (clojure-mode . lsp-deferred)
         (cider-mode . lsp-deferred)
         (yaml-mode . lsp-deferred)
         (dockerfile-mode . lsp-deferred)
         (terraform-mode . lsp-deferred)
         (sh-mode . lsp-deferred))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-on-type-formatting nil
        lsp-log-io nil
        lsp-diagnostics-provider :auto
        lsp-enable-folding t
        lsp-enable-imenu t
        lsp-enable-snippet t
        lsp-enable-completion-at-point t
        lsp-keep-workspace-alive nil
        lsp-eldoc-enable-hover t
        lsp-eldoc-render-all nil
        lsp-enable-xref t
        lsp-enable-links t
        lsp-enable-indentation t
        lsp-enable-file-watchers t
        lsp-file-watch-threshold 1000
        lsp-session-file (expand-file-name "lsp-session" user-emacs-directory)
        lsp-auto-guess-root t
        lsp-restart 'auto-restart
        lsp-enable-dap-auto-configure nil)

  ;; Performance tuning
  (setq read-process-output-max (* 1024 1024)
        lsp-completion-provider :capf
        lsp-idle-delay 0.5)

  ;; Disable features that slow down lsp-mode
  (setq lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-text-document-color nil
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil))

;; UI enhancements for LSP
(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-show-with-mouse t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-delay 1.0)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-delay 1.0)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-list-width 60)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-imenu-enable t)
  (lsp-ui-imenu-kind-position 'top)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

;; Company integration for auto-completion
(use-package company-lsp
  :disabled t
  :ensure t
  :after (company lsp-mode)
  :config
  (push 'company-lsp company-backends))

;; Ivy integration
(use-package lsp-ivy
  :ensure t
  :after (ivy lsp-mode)
  :commands lsp-ivy-workspace-symbol
  :config
  (define-key lsp-mode-map (kbd "C-c l s") 'lsp-ivy-workspace-symbol))

;; Treemacs integration
(use-package lsp-treemacs
  :ensure t
  :after (treemacs lsp-mode)
  :commands lsp-treemacs-errors-list
  :config
  (lsp-treemacs-sync-mode 1))

;; Java-specific LSP configuration
(use-package lsp-java
  :ensure t
  :after lsp-mode
  :hook (java-mode . lsp-deferred)
  :config
  (setq lsp-java-vmargs
        '("-XX:+UseParallelGC"
          "-XX:GCTimeRatio=4"
          "-XX:AdaptiveSizePolicyWeight=90"
          "-Dsun.zip.disableMemoryMapping=true"
          "-Xmx2G"
          "-Xms100m")))

;; Python-specific LSP configuration
(use-package lsp-pyright
  :ensure t
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

;; Debug Adapter Protocol support
(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-auto-configure-mode)
  (require 'dap-java)
  (require 'dap-python))

;; Which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; Additional language server configurations
(with-eval-after-load 'lsp-mode
  ;; TypeScript/JavaScript
  (setq lsp-clients-typescript-prefer-use-project-ts-server t)
  
  ;; Go
  (setq lsp-go-analyses '((fieldalignment . t)
                          (nilness . t)
                          (unusedwrite . t)
                          (unusedparams . t)))
  
  ;; Rust
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-server-display-inlay-hints t)
  
  ;; Ruby
  (setq lsp-solargraph-use-bundler t))

;; Key bindings
(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c l r") 'lsp-rename)
  (define-key lsp-mode-map (kbd "C-c l a") 'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c l f") 'lsp-format-buffer)
  (define-key lsp-mode-map (kbd "C-c l F") 'lsp-format-region)
  (define-key lsp-mode-map (kbd "C-c l g") 'lsp-goto-implementation)
  (define-key lsp-mode-map (kbd "C-c l G") 'lsp-goto-type-definition)
  (define-key lsp-mode-map (kbd "C-c l d") 'lsp-describe-thing-at-point)
  (define-key lsp-mode-map (kbd "C-c l e") 'lsp-treemacs-errors-list)
  (define-key lsp-mode-map (kbd "C-c l s") 'lsp-ivy-workspace-symbol)
  (define-key lsp-mode-map (kbd "C-c l S") 'lsp-ivy-global-workspace-symbol)
  (define-key lsp-mode-map (kbd "C-c l h") 'lsp-ui-doc-show)
  (define-key lsp-mode-map (kbd "C-c l H") 'lsp-ui-doc-hide)
  (define-key lsp-mode-map (kbd "C-c l l") 'lsp-lens-mode)
  (define-key lsp-mode-map (kbd "C-c l m") 'lsp-ui-imenu))

(provide 'init-lsp)
;;; init-lsp.el ends here