;;
;; CS 161 Homework 1
;; Name: Darin Minamoto
;;

;; Checks if a tree contains the specific number
(defun tree-contains (n tree)
  (cond
    ; if tree is a list 
    ; Check all three leaves if they have n
    ((listp tree) (or
		    (tree-contains n (nth 0 tree))
		    (tree-contains n (nth 1 tree))
		    (tree-contains n (nth 2 tree))))
    ; if tree is value
    ; check value if tree contains it
    (t (cond
	 ((= n tree) t)
	 (t nil)))))

