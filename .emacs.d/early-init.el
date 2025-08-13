;;; early-init.el --- Early initialization for Emacs 30+

;;; Commentary:
;; This file is loaded before init.el in Emacs 27+
;; It's used for settings that benefit from being set early

;;; Code:

;; Defer garbage collection threshold during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reset gc values after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)  ; 16MB
                  gc-cons-percentage 0.1)))

;; Prevent package.el loading packages prior to init.el
(setq package-enable-at-startup nil)

;; Native compilation settings for Emacs 30
(when (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (setq native-comp-async-report-warnings-errors nil
        native-comp-deferred-compilation t
        package-native-compile t))

;; Disable some GUI elements early
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Resizing the frame can be expensive
(setq frame-inhibit-implied-resize t)

;; Ignore X resources
(advice-add #'x-apply-session-resources :override #'ignore)

;; Faster to disable these here (before they're loaded)
(setq site-run-file nil)

(provide 'early-init)
;;; early-init.el ends here