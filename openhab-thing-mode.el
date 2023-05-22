;;; openhab-thing-mode.el --- openHAB things -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Peter Hoeg
;;
;; Author: Peter Hoeg <peter@hoeg.com>
;; Version: 0.0.1
;; Created: 2023
;; Keywords: languages
;; Homepage: https://github.com/peter/openhab-mode
;; SPDX-License-Identifier: GPL-3.0-or-later
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Support for openHAB things.
;;
;;; Code:

;;;###autoload
(define-derived-mode openhab-thing-mode openhab-mode "openHAB thing"
  "Major mode for editing openHAB thing files."

  (rx-define spaces (one-or-more space))
  (rx-define variable-name (one-or-more (any alpha)))
  (rx-define thing-kind (one-or-more (any alnum ":" "-" "_")))
  (rx-define thing-name (one-or-more (any alnum ":" "-" "_")))
  (rx-define desc (one-or-more (any alnum ":" "-" "_" space)))
  (rx-define type-words (or "Bridge" "Thing"))

  (setq-local font-lock-defaults `(((,(rx "//" (one-or-more not-newline) eol) . 'font-lock-comment-face)
                                    (,(rx bol (optional spaces) type-words spaces (group thing-kind) spaces (group thing-name)) . (1 'font-lock-keyword-face))
                                    (,(rx bol (optional spaces) type-words spaces (group thing-kind) spaces (group thing-name)) . (2 'font-lock-function-name-face))
                                    (,(rx type-words) . 'font-lock-type-face)
                                    (,(rx (optional spaces) (group variable-name) "=") . (1 'font-lock-variable-name-face))
                                    (,(rx (or "Channels" "Type")) . 'font-lock-builtin-face)
                                    (,(rx (one-or-more digit)) . font-lock-constant-face)
                                    ))
              imenu-generic-expression `(("Thing"  ,(rx bol "Thing"  spaces (group thing-name spaces (optional thing-name spaces) "\"" (one-or-more desc) "\"")) 1)
                                         ("Bridge" ,(rx bol "Bridge" spaces (group thing-name spaces (optional thing-name spaces) "\"" (one-or-more desc) "\"")) 1))))

(provide 'openhab-thing-mode)
;;; openhab-thing-mode.el ends here
