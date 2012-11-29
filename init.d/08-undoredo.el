;; tree-undo
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; redo
(require 'redo+)
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
;; 大量のundoに耐えられるようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
