;;; openhab-persistence-mode.el --- openHAB sitemaps -*- lexical-binding: t; -*-
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
(define-derived-mode openhab-persistence-mode openhab-mode "openHAB sitemap"
  "Major mode for editing openHAB sitemap files."

  (rx-define spaces (one-or-more space))
  (rx-define rule-name (one-or-more (any alnum "_")))
  (rx-define type-words (or "Items" "Strategies"))

  (setq-local font-lock-defaults `(((,(rx "//" (one-or-more not-newline) eol) . 'font-lock-comment-face)
                                    (,(rx (or "default" "strategy")) . 'font-lock-builtin-face)
                                    (,(rx bol (optional spaces) type-words) . 'font-lock-type-face)
                                    (,(rx (optional spaces) (group rule-name) spaces ":") . (1 'font-lock-builtin-face))
                                    ))
              imenu-generic-expression `((nil ,(rx bol (group type-words)) 1))))

(provide 'openhab-persistence-mode)
;;; openhab-persistence-mode.el ends here
