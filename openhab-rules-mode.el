;;; package --- openHAB rules
;;;
;;; Commentary:
;;;
;;; Code:
(require 'xbase-mode)

(defvar openhab-rules-mode-hook nil)

(defvar openhab-rules-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for openHAB rules major mode.")

(defconst xbase-keywords '()
  "Keywords.")
(defconst xbase-constants '("ON" "OFF" "INCREASE" "DECREASE")
  "Constants.")
(defconst xbase-builtins '("var" "rule" "when" "or" "then" "end" "new")
  "Builtins.")
(defconst xbase-functions '("postUpdate" "sendCommand")
  "Functions.")
(defconst xbase-types '("Number" "String")
  "Types.")

(defconst xbase-mode-imenu-generic-expression
  '(("Rule"  "^rule*\\(.*\\)" 1)
    )
  "Imenu regexp."
  )

(defvar xbase-font-lock-keywords
  `(
    ;; NOTE: order matters, because once colored, that part won't change.
    (,(regexp-opt xbase-builtins  'words) . font-lock-builtin-face)
    (,(regexp-opt xbase-keywords  'words) . font-lock-keyword-face)
    (,(regexp-opt xbase-constants 'words) . font-lock-constant-face)
    (,(regexp-opt xbase-functions 'words) . font-lock-function-name-face)
    (,(regexp-opt xbase-types     'words) . font-lock-type-face))
  "CUE mode syntax coloring.")


;;;###autoload
(define-derived-mode openhab-rules-mode xbase-mode "openhab rule"
  "Major mode for editing openHAB rules."
  (setq-local
   comment-start "//"
   font-lock-defaults '((xbase-font-lock-keywords))
   ;; imenu-generic-expression xbase-mode-imenu-generic-expression
   )
  (run-hooks 'openhab-rules-mode-hook))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.rule\\'" . openhab-rules-mode))

(provide 'openhab-rules-mode)
;;; openhab-rules-mode.el ends here
