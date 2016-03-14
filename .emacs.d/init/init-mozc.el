(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'overlay)
  (set-face-attribute 'mozc-cand-overlay-even-face 'nil
    :foreground "snow1" :background "MediumBlue" :underline nil)
  (set-face-attribute 'mozc-cand-overlay-odd-face 'nil
    :foreground "snow1" :background "MediumBlue" :underline nil)
  (set-face-attribute 'mozc-cand-overlay-focused-face 'nil
    :background "MediumBlue" :foreground "orange1" :underline nil))

(global-set-key (kbd "C-o") 'toggle-input-method)

(provide 'init-mozc)

