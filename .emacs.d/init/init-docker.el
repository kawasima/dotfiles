;;; init-docker.el --- Settings for docker
;;; Commentary:
;;; Code:
(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

(use-package docker-compose-mode
  :ensure t
  :mode "docker-compose.yml\\'")
(provide 'init-docker)
;;; init-docker.el ends here
