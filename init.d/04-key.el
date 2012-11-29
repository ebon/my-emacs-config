;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-
;;; 04-key.el --- key mapping configuretion
;;; Commentary:
;;; Key bindings
;;; Code:

;; Translattion
;;(keyboard-translate ?\C-h ?\C-?)            ;; C-h to backspace
(global-set-key "\C-h" 'backward-delete-char) ;; C-h to backspace
(global-set-key "\M-?" 'help-for-help)        ;; help key変更
(define-key global-map (kbd "C--") 'undo)     ;; undo ;; redo -> C-? from undo-tree
(global-set-key "\M-o" 'back-to-indentation)  ;; M-m to M-o
(global-set-key "\M-H" 'mark-defun)  ;; redefun mark-defun to use it in window-move

;; window cycle: C-;で右,C-M-;で左回り
(defun other-window-or-split-left ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window -1))
(defun other-window-or-split-right ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-M-;") 'other-window-or-split-left)
(global-set-key (kbd "C-;") 'other-window-or-split-right)

;; rgrep
(define-key global-map (kbd "M-C-g") 'rgrep)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;; iswitchb
(global-set-key (kbd "C-x b") 'iswitchb-buffer)

;; File finging
(global-set-key (kbd "C-c v") 'revert-buffer)

;;; move to window
(defmacro global-set-key-fn (key args &rest body)
  `(global-set-key ,key (lambda ,args ,@body)))

(global-set-key-fn (kbd "M-i") nil (interactive) (move-to-window-line 0))
(global-set-key-fn (kbd "M-m") nil (interactive) (move-to-window-line -1))
(global-set-key-fn (kbd "M-l") nil (interactive) (recenter-top-bottom))
;; (global-set-key-fn (kbd "C-:") nil (interactive) (move-to-window-line-top-bottom))


;;; move paragraph
(global-set-key-fn (kbd "M-p") nil (interactive) (backward-paragraph))
(global-set-key-fn (kbd "M-n") nil (interactive) (forward-paragraph))

;;; cursol undo
(define-key global-map (kbd "C-c u") 'point-undo)
(define-key global-map (kbd "C-c p") 'point-redo)

;;; Region
;; Thing at Point optional utilities
(require 'thingopt)
(define-thing-commands)
(global-set-key (kbd "C-$") 'mark-word*)
(global-set-key (kbd "C-]") 'mark-string)
(global-set-key (kbd "C-/") 'mark-up-list)

;; -------------------
;; @ Key chord
;; -------------------
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "hu"     'undo)
(key-chord-define-global "qw"     'redo)
(key-chord-define-global "ji"     "-")
(key-chord-define-global "jo"     "`")
(key-chord-define-global "gl"     'goto-last-change)
(key-chord-define-global "gr"     'goto-last-change-reverse)
(key-chord-define-global "dw" 'kill-word*)
(key-chord-define-global "yw" 'copy-word)
(key-chord-define-global "vw" 'mark-word*) ; more convinent C-M-SPC ?
(key-chord-define-global "ds" 'kill-sexp*)
(key-chord-define-global "ys" 'copy-sexp)
(key-chord-define-global "vs" 'mark-sexp*)
(key-chord-define-global "dq" 'kill-string)
(key-chord-define-global "yq" 'copy-string)
(key-chord-define-global "vq" 'mark-string)
(key-chord-define-global "dl" 'kill-up-list)
(key-chord-define-global "yl" 'copy-up-list)
(key-chord-define-global "vl" 'mark-up-list)

;; ;; Space chord
;; (require 'space-chord)
;; (space-chord-define-global "h" 'windowmove-left)
;; (space-chord-define-global "l" 'windowmove-right)
;; (space-chord-define-global "k" 'windowmove-up)
;; (space-chord-define-global "j" 'windowmove-down)