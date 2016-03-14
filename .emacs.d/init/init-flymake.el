;;; Flymake
(when (require 'flymake nil t)
  (add-hook 'find-file-hook 'flymake-find-file-hook)
  (defun flymake-show-and-sit ()
    "Displays the error/warning for the current line in the minibuffer"
    (interactive)
    (progn
      (let* ((line-no (flymake-current-line-no) )
              (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
              (count (length line-err-info-list)))
        (while (> count 0)
          (when line-err-info-list
            (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
                    (full-file
                      (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                    (text (flymake-ler-text (nth (1- count) line-err-info-list)))
                    (line (flymake-ler-line (nth (1- count) line-err-info-list))))
              (message "[%s] %s" line text)))
          (setq count (1- count)))))
    (sit-for 60.0))
  (global-set-key "\C-cd" 'flymake-show-and-sit)
  (defun flymake-simple-generic-init (cmd &optional opts)
    (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
            (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
      (list cmd (append opts (list local-file)))))
 
  (defun flymake-simple-make-or-generic-init (cmd &optional opts)
    (if (file-exists-p "Makefile")
      (flymake-simple-make-init)
      (flymake-simple-generic-init cmd opts)))

  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
 
  (defun flymake-c-init ()
    (flymake-simple-make-or-generic-init
      "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))
 
  (defun flymake-cc-init ()
    (flymake-simple-make-or-generic-init
     "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

  (defun flymake-html-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "tidy" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.html$" flymake-html-init))
 
  (push '("\\.c\\'" flymake-c-init) flymake-allowed-file-name-masks)
  (push '("\\.\\(cc\\|cpp\\|C\\|CPP\\|hpp\\)\\'" flymake-cc-init)
    flymake-allowed-file-name-masks))

(provide 'init-flymake)

