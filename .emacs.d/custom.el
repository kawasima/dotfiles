;;; custom.el --- Custom variables and faces

;;; Commentary:
;; This file contains custom variables and faces set by Emacs' customize interface.
;; It's separated from init.el for cleaner organization.

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dea4b7d43d646aa06a4f705a58f874ec706f896c25993fcf73de406e27dc65ba"
     "76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3"
     "ec5f697561eaf87b1d3b087dd28e61a2fc9860e4c862ea8e6b0b77bd4967d0ba"
     "e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf"
     "2022c5a92bbc261e045ec053aa466705999863f14b84c012a43f55a95bf9feb8"
     default))
 '(js-indent-level 2)
 '(native-comp-async-report-warnings-errors nil)
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((claude-code :url "https://github.com/stevemolitor/claude-code.el")))
 '(yas-trigger-key "TAB"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t :height 0.9))))

;;; custom.el ends here