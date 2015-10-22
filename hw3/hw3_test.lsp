;;
;; Tests for homework 3
;;

(load "hw3.lsp")
(load "../hwtestrunner.lsp")

(setq tests '(
              ; goal-test testcases
              ((goal-test nil) t "goal-test1: If no board you win by default :P")
              ((goal-test '((0 0 0)
                            (1 1 1)
                            (5 5 6))) t "goal-test2: testing goal is true")
              ((goal-test '((0 0 0)
                            (1 1 1)
                            (5 2 6))) nil "goal-test3: testing not goal is false")
              ; h0 testcases
              ((h0 '((1 2 3) (4 5 6))) 0 "h0: Yes it returns 0")
              ((h0 nil) 0 "h0: IT RETURNS ZERO")
              ((h0 t) 0 "h0: STAHP")
              ; h1 testcases
              ((h1 nil) 0 "h1: nil state returns 0")
              ((h1 '((1 3 5)
                     (4 5 5)
                     (0 0 0))) 0 "h1: no misplaced boxes returns 0")
              ((h1 '((2))) 1 "h1: one misplaced box returns 1")
              ((h1 '((2 2 2)
                     (2 2 2)
                     (2 2 2))) 9 "h1: all misplaced boxes returns 9")
              ))

(run-tests tests)
