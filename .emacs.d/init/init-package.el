(require 'package)

;; Use HTTPS for package archives
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
	("melpa" . "https://melpa.org/packages/")))

;; Initialize package.el
(unless (bound-and-true-p package--initialized)
  (package-initialize))

(eval-when-compile
  (require 'use-package))

;; Enable auto-install of missing packages
(setq use-package-always-ensure t)

(provide 'init-package)
