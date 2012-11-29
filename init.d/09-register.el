(setq dotfiles-dir (file-name-directory
                    (or load-file-name (buffer-file-name))))

(dolist (r `((?i (file . ,(concat dotfiles-dir "init.el")))))
  (set-register (car r) (cadr r)))
