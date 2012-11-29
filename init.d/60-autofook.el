;; 行末のwhitespace削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 最終更新日時の自動埋め込み
;; 表示形式
(setq time-stamp-start "last updated : ")
;;(setq time-stamp-format "%04y/%02m/%02d-%02H:%02M:%02S")
;; 行端のデリミタ
(setq time-stamp-end "$")
(if (not (memq 'time-stamp write-file-hooks))
    (setq write-file-hooks
          (cons 'time-stamp write-file-hooks)))