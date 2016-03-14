;;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
	   ,(format
	      "Try to expand a snippet before point, then call `%s' as usual"
	      function-symbol)
	   (let ((yas/fallback-behavior nil))
	     (unless (and (interactive-p)
		       (yas/expand))
	       ad-do-it)))))

(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(provide 'init-yasnippet)

