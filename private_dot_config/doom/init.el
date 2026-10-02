;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-

(doom! :input

       :completion
       (corfu +orderless +icons)
       (vertico +icons)

       :ui
       doom
       dashboard
       hl-todo
       modeline
       ophints
       (popup +defaults)
       (vc-gutter +pretty)
       vi-tilde-fringe
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       snippets
       (whitespace +guess +trim)

       :emacs
       (dired +icons)
       electric
       tramp
       undo
       vc

       :term
       (ghostel +everywhere)

       :checkers
       syntax

       :tools
       (eval +overlay)
       (lsp +eglot)
       lookup
       magit
       tree-sitter

       :os
       (:if (featurep :system 'macos) macos)

       :lang
       emacs-lisp
       markdown
       org
       sh
       data
       (json +lsp)
       (javascript +lsp)
       plantuml
       (python +lsp)
       (rust +lsp)
       web
       (yaml +lsp)

       :email

       :app

       :config
       (default +bindings +smartparens))
