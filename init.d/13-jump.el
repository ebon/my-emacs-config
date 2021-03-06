;;; ace-jump-mode
;;; [[http://d.hatena.ne.jp/rkworks/20120520/1337528737][Emacsで1～3ストロークで画面上の任意の場所に移動するための設定 - non-nil]]
(require 'ace-jump-mode)
;; (defun add-keys-to-ace-jump-mode (prefix c &optional mode)
;;   (define-key global-map
;;     (read-kbd-macro (concat prefix (string c)))
;;     `(lambda ()
;;        (interactive)
;;        (funcall (if (eq ',mode 'word)
;;                     #'ace-jump-word-mode
;;                   #'ace-jump-char-mode) ,c))))

;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-" c))
;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-" c))
;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-M-" c 'word))
;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-M-" c 'word))


(defun add-hyper-char-to-ace-jump-word-mode (c)
  (define-key global-map
    (read-kbd-macro (concat "H-" (string c)))
    `(lambda ()
       (interactive)
       (setq ace-jump-query-char ,c)
       (setq ace-jump-current-mode 'ace-jump-word-mode)
       (ace-jump-do (concat "\\b"
                            (regexp-quote (make-string 1 ,c)))))))

(loop for c from ?0 to ?9 do (add-hyper-char-to-ace-jump-word-mode c))
(loop for c from ?A to ?Z do (add-hyper-char-to-ace-jump-word-mode c))
(loop for c from ?a to ?z do (add-hyper-char-to-ace-jump-word-mode c))
;; (loop for c from ?Å to ?ø do (add-hyper-char-to-ace-jump-word-mode c))