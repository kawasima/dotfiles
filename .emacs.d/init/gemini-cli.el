;;; gemini-cli.el --- Emacs interface for Gemini CLI -*- lexical-binding: t; -*-

;; Copyright (C) 2025

;; Author: Your Name <your.email@example.com>
;; Version: 0.1.0
;; Package-Requires: ((emacs "28.1") (eat "0.9.4") (transient "0.5.0"))
;; Keywords: convenience, ai, gemini
;; URL: https://github.com/yourusername/gemini-cli.el

;;; Commentary:

;; This package provides an Emacs interface for interacting with Gemini CLI.
;; It allows you to start Gemini CLI sessions, send code and text to Gemini,
;; and manage the interaction through a terminal interface.

;;; Code:

(require 'eat)
(require 'project)
(require 'transient)
(require 'cl-lib)

(defgroup gemini-cli nil
  "Emacs interface for Gemini CLI."
  :group 'convenience
  :prefix "gemini-cli-")

(defcustom gemini-cli-program "gemini"
  "Path to the Gemini CLI executable."
  :type 'string
  :group 'gemini-cli)

(defcustom gemini-cli-args nil
  "Additional arguments to pass to Gemini CLI."
  :type '(repeat string)
  :group 'gemini-cli)

(defcustom gemini-cli-term-name "eat-color"
  "Terminal type for Gemini CLI sessions."
  :type 'string
  :group 'gemini-cli)

(defcustom gemini-cli-startup-delay 1.0
  "Delay in seconds before sending initial input to Gemini CLI."
  :type 'number
  :group 'gemini-cli)

(defcustom gemini-cli-large-buffer-threshold 1000
  "Number of lines above which to prompt before sending buffer contents."
  :type 'integer
  :group 'gemini-cli)

(defcustom gemini-cli-window-fraction 0.33
  "Fraction of frame height for Gemini CLI window."
  :type 'number
  :group 'gemini-cli)

(defcustom gemini-cli-ask-for-directory t
  "Whether to ask for directory when starting Gemini CLI without a project."
  :type 'boolean
  :group 'gemini-cli)

(defvar gemini-cli--buffers (make-hash-table :test 'equal)
  "Hash table mapping directories to Gemini CLI buffers.")

(defvar gemini-cli--current-window-config nil
  "Stores window configuration before showing Gemini CLI.")

(defun gemini-cli--buffer-name (directory)
  "Generate buffer name for Gemini CLI in DIRECTORY."
  (format "*gemini-cli: %s*" (abbreviate-file-name directory)))

(defun gemini-cli--get-buffer (directory)
  "Get or create Gemini CLI buffer for DIRECTORY."
  (let ((buffer-name (gemini-cli--buffer-name directory)))
    (or (gethash directory gemini-cli--buffers)
        (let ((buffer (get-buffer buffer-name)))
          (when (and buffer (buffer-live-p buffer))
            (puthash directory buffer gemini-cli--buffers)
            buffer)))))

(defun gemini-cli--ensure-process (buffer directory)
  "Ensure Gemini CLI process is running in BUFFER for DIRECTORY."
  (with-current-buffer buffer
    (unless (get-buffer-process buffer)
      (let ((default-directory directory)
            (process-environment (cons (format "TERM=%s" gemini-cli-term-name)
                                     process-environment)))
        (apply #'eat gemini-cli-program gemini-cli-args)
        (setq-local gemini-cli--directory directory)
        (run-at-time gemini-cli-startup-delay nil
                     (lambda ()
                       (when (buffer-live-p buffer)
                         (with-current-buffer buffer
                           (goto-char (point-max))))))))))

(defun gemini-cli--get-project-directory ()
  "Get the current project directory or default directory."
  (or (when-let ((project (project-current)))
        (project-root project))
      default-directory))

(defun gemini-cli--send-string (string &optional buffer)
  "Send STRING to Gemini CLI in BUFFER."
  (let ((buffer (or buffer (gemini-cli--get-or-create-buffer))))
    (when buffer
      (with-current-buffer buffer
        (goto-char (point-max))
        (eat-term-send-string (get-buffer-process buffer) string)))))

(defun gemini-cli--get-or-create-buffer (&optional directory)
  "Get or create Gemini CLI buffer for DIRECTORY."
  (let ((directory (or directory (gemini-cli--get-project-directory))))
    (or (gemini-cli--get-buffer directory)
        (let ((buffer (generate-new-buffer (gemini-cli--buffer-name directory))))
          (puthash directory buffer gemini-cli--buffers)
          (gemini-cli--ensure-process buffer directory)
          buffer))))

(defun gemini-cli--show-buffer (buffer)
  "Display Gemini CLI BUFFER in a window."
  (unless (get-buffer-window buffer)
    (setq gemini-cli--current-window-config (current-window-configuration))
    (let ((window (split-window-below (- (floor (* (frame-height)
                                                  gemini-cli-window-fraction))))))
      (set-window-buffer window buffer)
      (select-window window))))

;;;###autoload
(defun gemini-cli (&optional directory)
  "Start or show Gemini CLI for the current project or DIRECTORY."
  (interactive)
  (let* ((directory (or directory
                       (gemini-cli--get-project-directory)
                       (when gemini-cli-ask-for-directory
                         (read-directory-name "Start Gemini CLI in directory: "))))
         (buffer (gemini-cli--get-or-create-buffer directory)))
    (gemini-cli--show-buffer buffer)))

;;;###autoload
(defun gemini-cli-send-region (start end)
  "Send region from START to END to Gemini CLI."
  (interactive "r")
  (let ((content (buffer-substring-no-properties start end))
        (buffer (gemini-cli--get-or-create-buffer)))
    (when buffer
      (gemini-cli--show-buffer buffer)
      (gemini-cli--send-string content)
      (gemini-cli--send-string "\n"))))

;;;###autoload
(defun gemini-cli-send-buffer ()
  "Send entire buffer contents to Gemini CLI."
  (interactive)
  (let ((lines (count-lines (point-min) (point-max))))
    (when (or (<= lines gemini-cli-large-buffer-threshold)
              (y-or-n-p (format "Send %d lines to Gemini CLI? " lines)))
      (gemini-cli-send-region (point-min) (point-max)))))

;;;###autoload
(defun gemini-cli-send-command (command)
  "Send COMMAND string to Gemini CLI."
  (interactive "sCommand: ")
  (let ((buffer (gemini-cli--get-or-create-buffer)))
    (when buffer
      (gemini-cli--show-buffer buffer)
      (gemini-cli--send-string command)
      (gemini-cli--send-string "\n"))))

;;;###autoload
(defun gemini-cli-toggle ()
  "Toggle Gemini CLI window visibility."
  (interactive)
  (let* ((directory (gemini-cli--get-project-directory))
         (buffer (gemini-cli--get-buffer directory)))
    (if (and buffer (get-buffer-window buffer))
        (progn
          (delete-window (get-buffer-window buffer))
          (when gemini-cli--current-window-config
            (set-window-configuration gemini-cli--current-window-config)))
      (gemini-cli directory))))

;;;###autoload
(defun gemini-cli-kill ()
  "Kill current Gemini CLI process and buffer."
  (interactive)
  (let* ((directory (gemini-cli--get-project-directory))
         (buffer (gemini-cli--get-buffer directory)))
    (when buffer
      (when-let ((process (get-buffer-process buffer)))
        (kill-process process))
      (kill-buffer buffer)
      (remhash directory gemini-cli--buffers))))

;;;###autoload
(defun gemini-cli-kill-all ()
  "Kill all Gemini CLI processes and buffers."
  (interactive)
  (maphash (lambda (_dir buffer)
             (when (buffer-live-p buffer)
               (when-let ((process (get-buffer-process buffer)))
                 (kill-process process))
               (kill-buffer buffer)))
           gemini-cli--buffers)
  (clrhash gemini-cli--buffers))

;;;###autoload
(defun gemini-cli-send-file (filename)
  "Send contents of FILENAME to Gemini CLI."
  (interactive "fFile: ")
  (let ((buffer (gemini-cli--get-or-create-buffer)))
    (when buffer
      (gemini-cli--show-buffer buffer)
      (gemini-cli--send-string (format "File: %s\n" filename))
      (gemini-cli--send-string (with-temp-buffer
                                (insert-file-contents filename)
                                (buffer-string)))
      (gemini-cli--send-string "\n"))))

;;;###autoload
(defun gemini-cli-send-defun ()
  "Send current function definition to Gemini CLI."
  (interactive)
  (save-excursion
    (mark-defun)
    (gemini-cli-send-region (region-beginning) (region-end))))

;;;###autoload
(defun gemini-cli-explain-region (start end)
  "Ask Gemini to explain the selected region from START to END."
  (interactive "r")
  (let ((content (buffer-substring-no-properties start end)))
    (gemini-cli-send-command "Please explain this code:")
    (gemini-cli--send-string content)
    (gemini-cli--send-string "\n")))

;;;###autoload
(defun gemini-cli-fix-region (start end)
  "Ask Gemini to fix issues in the selected region from START to END."
  (interactive "r")
  (let ((content (buffer-substring-no-properties start end)))
    (gemini-cli-send-command "Please fix any issues in this code:")
    (gemini-cli--send-string content)
    (gemini-cli--send-string "\n")))

;;;###autoload
(defun gemini-cli-clear ()
  "Clear the Gemini CLI terminal."
  (interactive)
  (let ((buffer (gemini-cli--get-or-create-buffer)))
    (when buffer
      (with-current-buffer buffer
        (eat-term-send-string (get-buffer-process buffer) "\C-l")))))

;; Transient menu
;;;###autoload (autoload 'gemini-cli-menu "gemini-cli" nil t)
(transient-define-prefix gemini-cli-menu ()
  "Gemini CLI commands."
  ["Gemini CLI"
   ["Session"
    ("s" "Start/Show" gemini-cli)
    ("t" "Toggle" gemini-cli-toggle)
    ("k" "Kill" gemini-cli-kill)
    ("K" "Kill all" gemini-cli-kill-all)
    ("c" "Clear" gemini-cli-clear)]
   ["Send"
    ("r" "Region" gemini-cli-send-region)
    ("b" "Buffer" gemini-cli-send-buffer)
    ("f" "File" gemini-cli-send-file)
    ("d" "Defun" gemini-cli-send-defun)
    ("m" "Command" gemini-cli-send-command)]
   ["AI Actions"
    ("e" "Explain" gemini-cli-explain-region)
    ("x" "Fix" gemini-cli-fix-region)]])

;; Global minor mode
(defvar gemini-cli-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c g") #'gemini-cli-menu)
    map)
  "Keymap for `gemini-cli-mode'.")

;;;###autoload
(define-minor-mode gemini-cli-mode
  "Minor mode for Gemini CLI integration."
  :global t
  :lighter " Gemini"
  :keymap gemini-cli-mode-map)

(provide 'gemini-cli)
;;; gemini-cli.el ends here
