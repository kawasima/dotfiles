;;; init-java.el --- Modern Java development configuration

;;; Code:

(require 'project)
(require 'compile)

;; Tree-sitter support for Java (Emacs 30+)
(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (use-package java-ts-mode
    :mode ("\\.java\\'" . java-ts-mode)
    :hook (java-ts-mode . eglot-ensure)
    :config
    ;; Ensure tree-sitter grammar is installed
    (unless (treesit-language-available-p 'java)
      (message "Installing tree-sitter grammar for Java...")
      (treesit-install-language-grammar 'java))))

;; Fallback to regular java-mode for older Emacs
(unless (and (fboundp 'treesit-available-p) (treesit-available-p))
  (use-package java-mode
    :mode "\\.java\\'"
    :hook (java-mode . eglot-ensure)))

;; Eglot configuration for Java LSP
(use-package eglot
  :ensure nil  ; Built-in since Emacs 29
  :commands eglot-ensure
  :config
  ;; Configure jdtls for Java
  (add-to-list 'eglot-server-programs
               '((java-mode java-ts-mode) . ("jdtls"
                                              "-configuration" "~/.cache/jdtls"
                                              "-data" "~/.cache/jdtls/workspace"))))

;; Google Java Format
(defgroup google-java-format nil
  "Google Java Format integration."
  :group 'java)

(defcustom google-java-format-executable "google-java-format"
  "Path to the google-java-format executable."
  :type 'string
  :group 'google-java-format)

(defun google-java-format-buffer ()
  "Format the current buffer with google-java-format."
  (interactive)
  (when (and (derived-mode-p 'java-mode 'java-ts-mode)
             (executable-find google-java-format-executable))
    (let ((tmpfile (make-temp-file "google-java-format" nil ".java"))
          (coding-system-for-read 'utf-8)
          (coding-system-for-write 'utf-8))
      (write-region nil nil tmpfile)
      (if (zerop (call-process google-java-format-executable nil nil nil
                               "--replace" tmpfile))
          (progn
            (insert-file-contents tmpfile nil nil nil t)
            (message "Formatted with google-java-format"))
        (message "google-java-format failed"))
      (delete-file tmpfile))))

(define-minor-mode google-java-format-on-save-mode
  "Minor mode to format Java code with google-java-format on save."
  :lighter " GJF"
  (if google-java-format-on-save-mode
      (add-hook 'before-save-hook #'google-java-format-buffer nil t)
    (remove-hook 'before-save-hook #'google-java-format-buffer t)))

;; DAP mode for debugging
(use-package dap-mode
  :after eglot
  :config
  (dap-auto-configure-mode)
  (require 'dap-java))

;; Project utilities
(defun java-project-root ()
  "Find the root of the current Java project."
  (or (locate-dominating-file default-directory "pom.xml")
      (locate-dominating-file default-directory "build.gradle")
      (locate-dominating-file default-directory "build.gradle.kts")
      (project-root (project-current))))

(defun java-run-test-at-point ()
  "Run the Java test at point."
  (interactive)
  (let ((root (java-project-root)))
    (if root
        (let ((default-directory root))
          (cond
           ((file-exists-p "pom.xml")
            (compile (format "mvn test -Dtest=%s#%s"
                             (file-name-sans-extension
                              (file-name-nondirectory (buffer-file-name)))
                             (which-function))))
           ((or (file-exists-p "build.gradle")
                (file-exists-p "build.gradle.kts"))
            (compile (format "gradle test --tests %s.%s"
                             (file-name-sans-extension
                              (file-name-nondirectory (buffer-file-name)))
                             (which-function))))
           (t (message "Unknown project type"))))
      (message "No project root found"))))

(defun java-run-all-tests ()
  "Run all Java tests in the project."
  (interactive)
  (let ((root (java-project-root)))
    (if root
        (let ((default-directory root))
          (cond
           ((file-exists-p "pom.xml")
            (compile "mvn test"))
           ((or (file-exists-p "build.gradle")
                (file-exists-p "build.gradle.kts"))
            (compile "gradle test"))
           (t (message "Unknown project type"))))
      (message "No project root found"))))

(defun java-compile-project ()
  "Compile the current Java project."
  (interactive)
  (let ((root (java-project-root)))
    (if root
        (let ((default-directory root))
          (cond
           ((file-exists-p "pom.xml")
            (compile "mvn compile"))
           ((or (file-exists-p "build.gradle")
                (file-exists-p "build.gradle.kts"))
            (compile "gradle build"))
           (t (message "Unknown project type"))))
      (message "No project root found"))))

;; Key bindings
(defvar java-mode-map-common
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c j i") #'eglot-code-action-organize-imports)
    (define-key map (kbd "C-c j r") #'eglot-rename)
    (define-key map (kbd "C-c j f") #'google-java-format-buffer)
    (define-key map (kbd "C-c j t") #'java-run-test-at-point)
    (define-key map (kbd "C-c j T") #'java-run-all-tests)
    (define-key map (kbd "C-c j c") #'java-compile-project)
    (define-key map (kbd "C-c j d") #'dap-debug)
    map)
  "Common key bindings for Java modes.")

(with-eval-after-load 'java-mode
  (set-keymap-parent java-mode-map java-mode-map-common))

(with-eval-after-load 'java-ts-mode
  (set-keymap-parent java-ts-mode-map java-mode-map-common))

;; Enable google-java-format on save by default
(add-hook 'java-mode-hook #'google-java-format-on-save-mode)
(add-hook 'java-ts-mode-hook #'google-java-format-on-save-mode)

(provide 'init-java)
;;; init-java.el ends here