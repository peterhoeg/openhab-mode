;;; openhab-item-mode.el --- openHAB items -*- lexical-binding: t; -*-
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
;; Support for openHAB items.
;;
;;; Code:

(require 'openhab-mode)

;;;###autoload
(define-derived-mode openhab-item-mode openhab-mode "openHAB item"
  "Major mode for editing openHAB item files."

  (rx-define spaces (one-or-more space))
  (rx-define item-name (one-or-more (any alnum "_")))
  (rx-define type-words (or "Contact" "DateTime" "Dimmer" "Group" "Image" "Location" "Number" "Number:Angle" "Number:Dimensionless" "Number:Humidity" "Number:Length" "Number:Speed" "Number:Temperature" "Player" "String" "Switch"))

  (setq-local font-lock-defaults `(((,(rx "//" (one-or-more not-newline) eol) . 'font-lock-comment-face)
                                    (,(rx (or "ON" "OFF")) . 'font-lock-constant-face)
                                    (,(rx type-words spaces (group item-name)) . (1 'font-lock-function-name-face))
                                    (,(rx bol type-words) . 'font-lock-type-face)
                                    (,(rx "(" (group (one-or-more not-newline)) ")") . (1 'font-lock-function-name-face))
                                    (,(rx (group (one-or-more (any alpha))) "=") . (1 'font-lock-keyword-face))
                                    (,(rx "<" (group (one-or-more (any alpha))) ">") . (1 'font-lock-builtin-face))
                                    ;; 'font-lock-variable-name-face
                                    ))
              imenu-generic-expression `((nil ,(rx bol (group type-words space item-name space "\"" (one-or-more (any alnum space)) "\"")) 1))))

(provide 'openhab-item-mode)
;;; openhab-item-mode.el ends here
