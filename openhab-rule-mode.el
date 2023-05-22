;;; openhab-rule-mode.el --- openHAB rules -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Peter Hoeg
;;
;; Author: Peter Hoeg <peter@hoeg.com>
;; Version: 0.0.1
;; Created: 2023
;; Keywords: languages
;; Homepage: https://github.com/peterhoeg/openhab-mode
;; SPDX-License-Identifier: GPL-3.0-or-later
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Support for openHAB rules written using the openHAB DSL.
;;
;;; Code:

(defvar openhab-rule-mode-hook nil)

(defvar openhab-rule-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for openHAB rules major mode.")

(defconst openhab-rule-keywords
  '("Item" "Member of" "Time is" "Time cron" "System started" "Thing" "Channel"
    "triggered" "received" "command" "update" "changed" "from" "to")
  "Keywords.")
(defconst openhab-rule-constants
  '("NULL" "ON" "OFF" "INCREASE" "DECREASE" "UP" "DOWN")
  "Constants.")
(defconst openhab-rule-builtins
  '("import" "val" "var" "rule" "when" "or" "then" "end" "new")
  "Builtins.")
(defconst openhab-rule-functions
  '("postUpdate" "sendCommand")
  "Functions.")
(defconst openhab-rule-types
  '("Number" "String")
  "Types.")

(defconst openhab-rule-mode-imenu-generic-expression
  '(("Rule"     "^rule*\\(.*\\)" 1)
    ("Import"   "^import*\\(.*\\)" 1)
    ("Variable" "^va\\(l\\|r\\)*\\(.*\\)" 2))
  "Imenu regexp.")

(defvar openhab-rule-font-lock-keywords
  `(
    ;; NOTE: order matters, because once colored, that part won't change.
    (,(regexp-opt openhab-rule-builtins  'words) . font-lock-builtin-face)
    (,(regexp-opt openhab-rule-keywords  'words) . font-lock-keyword-face)
    (,(regexp-opt openhab-rule-constants 'words) . font-lock-constant-face)
    (,(regexp-opt openhab-rule-functions 'words) . font-lock-function-name-face)
    (,(regexp-opt openhab-rule-types     'words) . font-lock-type-face))
  "openHAB rules syntax coloring.")

(defvar openhab-rule-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?* ". 23" st)
    (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax table for `openhab-rule-mode'.")

;;; Rules - these are not actually correct.
;;; 1. If we are at the beginning of the buffer, indent to column 0.
;;; 2. If we are currently at an end line, then de-indent relative to the previous line.
;;; 3. If we first see an end line before our current line, then we should indent our current line to the same indentation as the end line.
;;; 4. If we first see a “start line” like rule, then we need to increase our indentation relative to that start line.
;;; 5. If none of the above apply, then do not indent at all.

(defun openhab-rule-mode-indent-line ()
  "Indent current line as an openHAB rule."
  (interactive)
  (beginning-of-line)
  (if (bobp)  ; Rule 1
      (indent-line-to 0)
    (let ((not-indented t) cur-indent)
      (if (looking-at "^[ \t]*end") ; Rule 2
          (progn
            (save-excursion
              (forward-line -1)
              (setq cur-indent (- (current-indentation) standard-indent)))
            (if (< cur-indent 0)
                (setq cur-indent 0)))
        (save-excursion
          (while not-indented
            (forward-line -1)
            (cond
             ((looking-at "^[ \t]*end")  ; Rule 3
              (setq cur-indent (current-indentation)
                    not-indented nil))
             ((looking-at "^[ \t]*\\(then\\|when\\)") ; Rule 4
              (setq cur-indent (+ (current-indentation) standard-indent)
                    not-indented nil))
             ((bobp)                    ; Rule 5
              (setq not-indented nil))))))
      (if cur-indent
          (indent-line-to cur-indent)
        (indent-line-to 0))))) ; If we didn't see an indentation hint, then allow no indentation

;;;###autoload
(define-derived-mode openhab-rule-mode prog-mode "openhab rule"
  "Major mode for editing openHAB rules."
  (setq-local
   comment-start "//"
   font-lock-defaults '((openhab-rule-font-lock-keywords))
   imenu-generic-expression openhab-rule-mode-imenu-generic-expression
   ;; indent-line-function 'openhab-rule-mode-indent-line
   )
  (use-local-map openhab-rule-mode-map)
  (run-hooks 'openhab-mode-hook)
  (run-hooks 'openhab-rule-mode-hook))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.rules\\'" . openhab-rule-mode))

(provide 'openhab-rule-mode)

;;; openhab-rule-mode.el ends here
