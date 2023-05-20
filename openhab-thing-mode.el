;;; openhab-thing-mode.el --- openHAB things -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Peter Hoeg
;;
;; Author: Peter Hoeg <peter@hoeg.com>
;; Maintainer: Peter Hoeg <peter@hoeg.com>
;; Created: May 20, 2023
;; Modified: May 20, 2023
;; Version: 0.0.1
;; Keywords: languages
;; Homepage: https://github.com/peter/openhab-mode
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(require 'imenu)

;;;###autoload
(define-derived-mode openhab-thing-mode prog-mode "openHAB thing"
  "Major mode for editing openHAB thing files."

  (rx-define spaces (one-or-more space))
  (rx-define variable-name (one-or-more (any alpha)))
  (rx-define thing-name (one-or-more (any alnum ":" "-" "_")))
  (rx-define desc (one-or-more (any alnum ":" "-" "_" space)))
  (rx-define type-words (or "Bridge" "Thing"))

  (setq-local comment-start "//"
              comment-end ""
              font-lock-defaults `((
                                    (,(rx "//" (one-or-more not-newline) eol) . 'font-lock-comment-face)
                                    (,(rx bol (optional spaces) type-words spaces (group thing-name)) . (1 'font-lock-function-name-face))
                                    (,(rx type-words) . 'font-lock-type-face)
                                    (,(rx (optional spaces) (group variable-name) "=") . (1 'font-lock-variable-name-face))
                                    (,(rx (or "Channels" "Type")) . 'font-lock-builtin-face)
                                    ))
              imenu-generic-expression `(("Bridge" ,(rx bol "Bridge" spaces (group thing-name spaces (optional thing-name spaces) "\"" (one-or-more desc) "\"")) 1)
                                         ("Thing"  ,(rx bol "Thing"  spaces (group thing-name spaces (optional thing-name spaces) "\"" (one-or-more desc) "\"")) 1))
              imenu-sort-function #'imenu--sort-by-name
              imenu-max-thing-length nil)

  (add-hook 'prometheus-data-mode-hook
            (lambda ()
              (display-line-numbers-mode))))

(provide 'openhab-thing-mode)
;;; openhab-thing-mode.el ends here
