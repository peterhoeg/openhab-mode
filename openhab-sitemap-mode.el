;;; openhab-sitemap-mode.el --- openHAB sitemaps -*- lexical-binding: t; -*-
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
;; Support for openHAB sitemaps.
;;
;;; Code:

(require 'openhab-mode)

;;;###autoload
(define-derived-mode openhab-sitemap-mode openhab-mode "openHAB sitemap"
  "Major mode for editing openHAB sitemap files."

  (rx-define spaces (one-or-more space))
  (rx-define item-name (one-or-more (any alnum "_")))
  (rx-define sitemap-name (one-or-more (any alnum "_")))
  (rx-define type-words (or "sitemap" "Default" "Frame" "Image" "Selection" "Setpoint" "Slider" "Switch" "Text" "Video"))

  (setq-local font-lock-defaults `(((,(rx "//" (one-or-more not-newline) eol) . 'font-lock-comment-face)
                                    (,(rx (optional spaces) type-words spaces (group sitemap-name)) . (1 'font-lock-function-name-face))
                                    (,(rx (optional spaces) "item=" (group item-name)) . (1 'font-lock-variable-name-face))
                                    (,(rx bol (optional spaces) type-words) . 'font-lock-type-face)
                                    (,(rx (group (one-or-more (any alpha))) "=") . (1 'font-lock-keyword-face))
                                    (,(rx (one-or-more digit)) . font-lock-constant-face)
                                    ;; 'font-lock-variable-name-face
                                    ))
              imenu-generic-expression `((nil ,(rx bol (group type-words space sitemap-name space "\"" (one-or-more (any alnum space)) "\"")) 1))))

(provide 'openhab-sitemap-mode)
;;; openhab-sitemap-mode.el ends here
