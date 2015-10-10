;;
;; Tests for homework 1
;;

(load "hw1.lsp")
(load "../hwtestrunner.lsp")

(setq tests '(
              ;;
              ;; TREE-CONTAINS tests
              ;;
              ((TREE-CONTAINS 3 '((1 2 3) 7 8)) t "Testing if element is in list") 
              ((TREE-CONTAINS 4 '((1 2 3) 7 8)) nil "Testing if element is not in list")
              ;;
              ;; TREE-MAX tests
              ;;
              ((TREE-MAX '((1 2 3) 7 8)) 8 "Testing if the max element in tree is returned")
              ;;
              ;; TREE-ORDER tests
              ;;
              ((TREE-ORDER 3) (3) "Testing tree order with one element")
              ((TREE-ORDER '((1 2 3) 7 8)) (1 2 3 7 8) "Testing tree order with many elements")
              ;;
              ;; SUB-LIST tests
              ;;
              ((SUB-LIST '(a b c d) 0 3) (a b c) "Testing sub-list")
              ((SUB-LIST '(a b c d) 3 1) (d) "Testing sub-list with length of 1")
              ((SUB-LIST '(a b c d) 2 0) nil "Testing sub-list with length of 0")
              ;;
              ;; SPLIT-LIST tests
              ;;
              ((SPLIT-LIST '(a b c d)) ((a b) (c d)) "Testing split list with even length")
              ((SPLIT-LIST '(a b c d e)) ((a b) (c d e)) "Testing split list with odd length")
              ((SPLIT-LIST '(a b c d e f)) ((a b c) (d e f)) "Testing split list with larger length")
              ;;
              ;; BTREE-HEIGHT tests
              ;;
              ((BTREE-HEIGHT 1) 0 "Testing the height of a binary tree represented by one number")
              ((BTREE-HEIGHT '(1 2)) 1 "Testing the height of a binary tree represented by one list")
              ((BTREE-HEIGHT '(1 (2 3))) 2 "Testing the height of a two level binary tree")
              ((BTREE-HEIGHT '((1 2) (3 4))) 2 "Testing another two level binary tree")
              ((BTREE-HEIGHT '((1 (2 3)) ((4 5) (6 7)))) 3 "Testing the height of a three level binary tree")
              ((BTREE-HEIGHT '(((1 2) (3 4)) ((5 6) (7 8)))) 3 "Testing another three level binary tree")
              ;;
              ;; LIST2BTREE tests
              ;;
              ((LIST2BTREE '(1)) 1 "Testing for list with one element")
              ((LIST2BTREE '(1 2)) (1 2) "Testing for list with two elements")
              ((LIST2BTREE '(1 2 3)) (1 (2 3)) "Testing that list splits properly with three elements")
              ((LIST2BTREE '(1 2 3 4)) ((1 2) (3 4)) "Testing that list splits properly with four elements")
              ((LIST2BTREE '(1 2 3 4 5 6 7)) ((1 (2 3)) ((4 5) (6 7))) "Testing large values 1")
              ((LIST2BTREE '(1 2 3 4 5 6 7 8)) (((1 2) (3 4)) ((5 6) (7 8))) "Testing large values 2")
              ;;
              ;; BTREE2LIST tests
              ;;
              ((BTREE2LIST 1) (1) "Testing that a number results in a list with the number")
              ((BTREE2LIST '(1 2)) (1 2) "Testing that a non-nested list results with the same list")
              ((BTREE2LIST '(1 (2 3))) (1 2 3) "Testing that a nested list returns the flattened list")
              ((BTREE2LIST '((1 2) (3 4))) (1 2 3 4) "Testing list with two nested lists")
              ((BTREE2LIST '((1 (2 3)) ((4 5) (6 7)))) (1 2 3 4 5 6 7) "Testing large nested list 1")
              ((BTREE2LIST '(((1 2) (3 4)) ((5 6) (7 8)))) (1 2 3 4 5 6 7 8) "Testing large nested list 2")
              ))

(run-tests tests)

