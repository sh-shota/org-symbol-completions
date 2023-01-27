(defun get-symbol-from-org-entites (name)
  "return symbol from org-entites (you can see list of symbols that can
   be converted to org-entites)."
  (setq entities-list (assoc name org-entities))
  (nth (- (safe-length entities-list) 1) entities-list)
  )

(defun org-symbol-completions ()
  "complete org-entities code to symbols"
  (interactive)
  (setq start-pos (point))

  (backward-word 1)  
  (forward-word 1)
  (setq end-pos (point))
  
  (backward-word 1)
  (setq is_slash (char-to-string (preceding-char)))
  (when (string= is_slash "\\")
    (setq word (buffer-substring-no-properties (point) end-pos))
    (setq symbol (get-symbol-from-org-entites word))
    (setq head (- (point) 1))
    (delete-region head end-pos)
    (insert symbol)
    )
  )

(global-set-key "\C-x\t" 'org-symbol-completions)
