;;
;; Tests for homework 3 helper functions
;;

(load "hw3.lsp")
(load "../hwtestrunner.lsp")

(setq tests '(
              ; new-move-position tests
              ((new-move-position '(4 2) t 1) (5 2) "Adding 1 to x axis increases column by 1")
              ((new-move-position '(4 2) t (- 1)) (3 2) "Subtracting 1 from x axis decreases column by 1")
              ((new-move-position '(4 2) nil 1) (4 3) "Adding 1 to y axis increases row by 1")
              ((new-move-position '(4 2) nil (- 1)) (4 1) "Subtracting 1 from y axis decreases row by 1")
              ; remove-box-or-keeper tests
              ((remove-box-or-keeper '((2 5 2) (2 2 2) (5 5 5)) 0 0) ((0 5 2) (2 2 2) (5 5 5)) "Removes box by setting it to blank")
              ((remove-box-or-keeper '((2 5 2) (2 2 2) (5 5 5)) 0 1) ((2 4 2) (2 2 2) (5 5 5)) "Removes box on star by setting it to star")
              ; add-box-or-keeper tests
              ((add-box-or-keeper '((0 4 0) (0 0 0) (4 4 4)) 0 0 2) ((2 4 0) (0 0 0) (4 4 4)) "Adds box to blank resulting in box")
              ((add-box-or-keeper '((0 4 0) (0 0 0) (4 4 4)) 0 1 2) ((0 5 0) (0 0 0) (4 4 4)) "Adds box to star resulting in boxstar")
              ((add-box-or-keeper '((0 4 0) (0 0 0) (4 4 4)) 0 0 3) ((3 4 0) (0 0 0) (4 4 4)) "Adds keeper to blank resulting in keeper")
              ((add-box-or-keeper '((0 4 0) (0 0 0) (4 4 4)) 0 1 3) ((0 6 0) (0 0 0) (4 4 4)) "Adds keeper to star resulting in keeperstar")
              ))

(run-tests tests)

