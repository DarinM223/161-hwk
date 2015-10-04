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

;; Returns the maximum value in the tree
(defun tree-max (tree)
  (cond
    ((listp tree) (max 
                    (tree-max (nth 0 tree))
                    (tree-max (nth 1 tree))
                    (tree-max (nth 2 tree))))
    (t tree)))

;; Returns a list representing the in-order traversal of the tree
(defun tree-order (tree)
  (cond
    ((listp tree) (append
                    (tree-order (nth 0 tree))
                    (tree-order (nth 1 tree))
                    (tree-order (nth 2 tree))))
    (t (list tree))))

