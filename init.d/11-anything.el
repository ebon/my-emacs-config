;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-
;;; init_anything.el --- emacs23 init setting elisp file
;;; Commentary:

;;; Code:
(require 'anything-startup)
(anything-read-string-mode '(string variable command))
(anything-read-string-mode 0)

(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)

(define-key global-map (kbd "C-q") 'anything)
(define-key anything-map (kbd "C-q") 'anything-exit-minibuffer)
(eval-after-load "anything"
  '(define-key anything-map (kbd "C-h") 'delete-backward-char))
(define-key anything-map (kbd "C-h") 'delete-backward-char)
;; (global-set-key (kbd "C-x C-f") 'anything-find-file)

;;; template for anything command
(defun anything-kill-ring ()
  (interactive)
  (anything 'anything-c-source-kill-ring nil nil nil nil "*anything kill ring*"))

(defadvice yank-pop (around anything-kill-ring-maybe activate)
  (if (not (eq last-command 'yank))
      (anything-kill-ring)
    ad-do-it))

;;; ends here