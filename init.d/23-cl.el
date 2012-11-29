;; common lisp mode
(defun slime-common-lisp ()
  (interactive)
  (setq inferior-lisp-program "/usr/local/bin/ccl")
  (add-to-list 'load-path "~/.emacs.d/elisp/slime/")
  (require 'slime)
  (slime-setup '(slime-repl))
  (slime))

;; (setq slime-net-coding-system 'utf-8-unix)  ; set utf8 input via slime

;;; auto-complete for slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
