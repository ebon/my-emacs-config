;; clojure
(require 'clojure-mode)

;;; paredit-mode
(require 'paredit)
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(show-paren-mode 1)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interacton-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'turn-on-paredit)
(add-hook 'inferior-lisp-mode-hook 'enable-paredit-mode)

(define-key paredit-mode-map (kbd "C-9") 'paredit-backward-slurp-sexp)
(define-key paredit-mode-map (kbd "C-0") 'paredit-forward-slurp-sexp)
(define-key paredit-mode-map (kbd "C-c C-n") 'paredit-forward-down)
(define-key paredit-mode-map (kbd "C-M-w") 'paredit-backward-kill-word)

;;; Slime misc
;; (defun clojure-mode-slime-font-lock ()
;;             (require 'clojure-mode)
;;             (let (font-lock-mode)
;;               (clojure-mode-font-lock-setup)))
;; (add-hook 'slime-repl-mode-hook 'clojure-mode-slime-font-lock)