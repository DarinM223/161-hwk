;;
;; Tests for homework 3
;;

(load "hw3.lsp")
(load "../hwtestrunner.lsp")

(setq tests '(
              ((goal-test nil) t "goal-test1: Testing on no list")
              ((goal-test '((0 0 0)
                            (1 1 1)
                            (5 5 6))) t "goal-test2: testing goal is true")
              ((goal-test '((0 0 0)
                            (1 1 1)
                            (5 2 6))) nil "goal-test3: testing not goal is false")
              ))

(run-tests tests)
