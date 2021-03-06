(use-package diminish
  :ensure t
  :config
  (progn
    (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
    (eval-after-load "simple" '(diminish 'auto-fill-function))
    (eval-after-load "eldoc" '(diminish 'eldoc-mode))
    (eval-after-load "guide-key" '(diminish 'guide-key-mode))
    (eval-after-load "highlight-parentheses" '(diminish 'highlight-parentheses-mode))
    (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode " sln"))
    (eval-after-load "projectile" '(diminish 'projectile-mode " prj"))
    (eval-after-load "paredit" '(diminish 'paredit-mode " par"))
    (eval-after-load "company" '(diminish 'company-mode " cmp"))
    (eval-after-load "cider" '(diminish 'cider-mode " cid"))
    (eval-after-load "typed-clojure-mode" '(diminish 'typed-clojure-mode " typ"))
    (eval-after-load "org-indent" '(diminish 'org-indent-mode))
    (eval-after-load "evil-org" '(diminish 'evil-org-mode))
    (eval-after-load "evil-cleverparens" '(diminish 'evil-cleverparens-mode))
    (eval-after-load "autorevert" '(diminish 'auto-revert-mode))
    (eval-after-load "helm" '(diminish 'helm-mode))))

(provide 'init-diminish)
