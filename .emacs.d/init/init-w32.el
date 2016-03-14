(set-face-font 'default "Source Code Pro-12")
(set-terminal-coding-system 'cp932)
(set-default-coding-systems 'cp932)
(setq default-input-method "W32-IME")
(w32-ime-initialize)
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[‚ ]" "[--]"))
  (require 'powerline)
  (powerline-default-theme))
(defun increase-font-size ()
  (interactive)
  (set-face-attribute 'default
		      nil
		      :height
		      (+ 10 (face-attribute 'default :height))))

(defun decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
		      nil
		      :height
		      ((lambda (h) (if (<= h 10) h (- h 10)))
		       (face-attribute 'default :height))))
(global-set-key [C-wheel-up] 'increase-font-size)
(global-set-key [C-wheel-down] 'decrease-font-size)

(provide 'init-w32)
