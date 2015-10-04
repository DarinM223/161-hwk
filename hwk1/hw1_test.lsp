;;
;; Tests
;;

(load "hw1.lsp")
(load "../hwtestrunner.lsp")

(setq tests '(
	      ((tree-contains 3 '((1 2 3) 7 8)) t "Testing if element is in list")
	      ((tree-contains 4 '((1 2 3) 7 8)) nil "Testing if element is not in list")
	      ))

(run-tests tests)
