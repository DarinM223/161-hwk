; Name: Darin Minamoto
; UID: 704140102

(defun reload ()
  (load "hw4.lsp"))

; Main n-queens function
; n: size of the n-queens problem
(defun queens (n)
  (dfs (cons '() (list (generate-state n))) n))

; places a queen
; s: state to place queen in
; col: column to place the queen in
; returns the state of the next iteration
(defun place-queen (s col) (update s col))

; dfs using forward checking
; s: list of queen moves
; n: size of n-queens problem
(defun dfs (s n)
  (let* ((queens (first s))
         (full-state (second s))
         (num-queens-placed (length queens)))
    (cond 
      ((and (= n num-queens-placed)) queens) 
      (t
        (dfs-helper (succ s n) n))))) 

; Helper function for dfs
; states: successor states
; n: size of n-queens problem
(defun dfs-helper (states n)
  (cond 
    ((null states) nil)
    (t 
      (or (dfs (first states) n) (dfs-helper (rest states) n)))))

; Checks if the state is valid
(defun state-valid (s) 
  (let* ((col-options (first s))) 
    (and 
      (or (null s) col-options)  
      (= (count nil s) 0)
      (cond 
        ((null s) t)
        ((= 1 (length col-options)) 
         (state-valid (place-queen s (first col-options))))
        (t (state-valid (rest s)))))))

; Returns all of the successors for a state
(defun succ (s n)
  (let* ((queens (first s))
         (state (second s))
         (col-options (first state)))
    (succ-helper queens col-options state n '())))

; Helper function for succ
; queens: list of queen moves
; col-options: options for the next move
; s: the current state
; succ-states: builds the successor states
(defun succ-helper (queens move-options s n succ-states)
  (cond 
    ((null move-options) succ-states)
    (t
      (let* ((add-queen (first move-options)) 
             (res-queens (append queens (list add-queen))) 
             (res-state (place-queen s add-queen)) 
             (new-state (cons res-queens (list res-state))))
        (cond 
          ((not (state-valid res-state)) 
           (succ-helper queens (rest move-options) s n succ-states))
          (t 
            (succ-helper queens (rest move-options) s n (cons new-state succ-states))))))))

; Creates the starting state for a board size
; n: size of the board for an n-queens problem
(defun generate-state (n) (generate-lists n n))

; Generates a list of lists of size n
; dec: a decrementing counter starting at n
(defun generate-lists (n dec)
  (cond 
    ((= dec 1) (list (generate-list n)))
    (t (cons (generate-list n) (generate-lists n (- dec 1))))))

; Generates a list of size n
(defun generate-list (n)
  (cond 
    ((= n 1) '(1))
    (t (append (generate-list (- n 1)) (list n)))))

(defun set-nth (l n v)
  (let ((len (length l)))
    (cond 
      ((> n len) nil)
      (t (append (butlast l (- len n -1)) (list v) (nthcdr n l))))))

(defun remove-val (l v)
  (remove-val-helper l v '()))

(defun remove-val-helper (l v build-l)
  (cond 
    ((null l) build-l)
    ((= (first l) v) (append build-l (rest l)))
    (t (remove-val-helper (rest l) v (append build-l (list (first l)))))))

; Removes three values from a list l
(defun remove-left-col-right (l left col right)
  (remove-left-col-right-helper l left col right '()))

; Helper for remove-left-col-right
(defun remove-left-col-right-helper (l left col right build-l)
  (let ((curr-v (first l)))
    (cond 
      ((null l) build-l)
      ((or (= curr-v left) (= curr-v col) (= curr-v right))
       (remove-left-col-right-helper (rest l) left col right build-l))
      (t (remove-left-col-right-helper (rest l) left col right (append build-l (list curr-v)))))))

; Returns values for the next row
(defun update (s col) (rest (update-helper '() s col col col)))

; Helper for update
; Puts rows from state-remaining into state-build
(defun update-helper (state-build state-remaining l col r)
  (cond 
    ((null state-remaining) state-build)
    (t
      (let ((new-row (update-row (first state-remaining) l col r)))
        (update-helper (append state-build (list new-row))
                          (rest state-remaining)
                          (- l 1)
                          col
                          (+ r 1))))))

; Updates a row of the game board
(defun update-row (row l col r)
  (remove-left-col-right row l col r))

; Adds a queen while checking validity
(defun add-queen (s col)
  (let ((new-s (append s (list col))))
    (cond 
      ((check-valid new-s) new-s)
      (t nil))))

; Checks if a state is valid
(defun check-valid (s) (check-valid-helper s 1 '() '()))

; Chelper for check-valid
(defun check-valid-helper (queens rown cols coords)
  (cond 
    ((null queens) t)
    (t 
      (cond ((or (> (count (first queens) cols) 0) 
                 (diagonals-exist (cons rown (first queens)) coords)) nil)
            (t (check-valid-helper (rest queens) 
                                   (+ rown 1) 
                                   (cons (first queens) cols)
                                   (cons (cons rown (first queens)) coords)))))))

; Checks if there is an diagonal for a coordinate
(defun diagonals-exist (coord coords)
  (let ((x1 (first coord))
        (x2 (first (first coords)))
        (y1 (rest coord))
        (y2 (rest (first coords))))
    (cond 
      ((null coords) nil)
      ((= 1 (my-abs (/ (- y2 y1) (- x2 x1)))) t)
      (t (diagonals-exist coord (rest coords))))))

; Custom implementation of abs
; val: the value to get the absolute value of
(defun my-abs (val)
  (cond 
    ((>= val 0) val)
    (t (* val -1))))

