;; CS161 Homework 2
;; Name: Darin Minamoto
;; UID: 704140102

;; Overall comment: Used lots of recursion and lisp stuff to implement these functions

;; Returns a list of nodes in tree in the order they will be visited by a depth-first search of the tree
;; tree: a tree as a list to run depth-first search on
(defun dfs (tree)
  (cond
    ((null tree) nil)
    ((atom tree) (list tree))
    (t (append (dfs (first tree)) (dfs (rest tree))))))

;; helper function for depth-first iterative-deepening search implementation
;; for the implementation of a depth-limited search
;; tree: tree as a list
;; maxdepth: max depth to limit by
(defun dls (tree maxdepth)
  (cond ((null tree) nil)
        ((< maxdepth 0) nil)
        ((atom tree) (list tree))
        (t (append (dls (car tree) (- maxdepth 1)) (dls (cdr tree) maxdepth)))))

;; iterative helper function for depth-first iterative-deepening search implementation
;; tree: tree as a list
;; maxdepth: max depth of tree to limit
;; level: current level 
(defun dfid-iterate (tree maxdepth level)
  (cond
    ((or (null tree) (< maxdepth level)) nil)
    (t (append (dls tree level) (dfid-iterate tree maxdepth (+ level 1))))))

;; implementation for depth-first iterative-deepening search
;; tree: tre as list
;; maxdepth: max depth of tree to limit
(defun dfid (tree maxdepth)
  (dfid-iterate tree maxdepth 0))


; These functions implement a depth-first solver for the missionary-cannibal
; problem. In this problem, three missionaries and three cannibals are trying to
; go from the east side of a river to the west side. They have a single boat
; that can carry two people at a time from one side of the river to the other.
; There must be at least one person in the boat to cross the river. There can
; never be more cannibals on one side of the river than missionaries. If there
; are, the cannibals eat the missionaries.

; In this implementation, a state is represented by a single list (MISSIONARIES
; CANNIBALS SIDE). SIDE represents which side the boat is currently on, and is T
; if it is on the east side and NIL if on the west side. MISSIONARIES and
; CANNIBALS represent the number of missionaries and cannibals on the same side
; as the boat. Thus, the initial state for this problem is (3 3 T) (three
; missionaries, three cannibals, and the boat are all on the east side of the
; river) and the goal state is (3 3 NIL).

; The main entry point for this solver is the function MC-DFS, which is called
; with the initial state to search from and the path to this state. It returns
; the complete path from the initial state to the goal state: this path is a
; list of intermediate problem states. The first element of the path is the
; initial state and the last element is the goal state. Each intermediate state
; is the state that results from applying the appropriate operator to the
; preceding state. If there is no solution, MC-DFS returns NIL.

; To call MC-DFS to solve the original problem, one would call (MC-DFS '(3 3 T)
; NIL) -- however, it would be possible to call MC-DFS with a different initial
; state or with an initial path.

; Examples of calls to some of the helper functions can be found after the code.


; FINAL-STATE takes a single argument (S), the current state, and returns T if
; it is the goal state (3 3 NIL) and NIL otherwise.
(defun final-state (s)
  (cond
    ((equal s '(3 3 nil)) t)
    (t nil)))

; NEXT-STATE returns the state that results from applying an operator to the
; current state. It takes three arguments: the current state (S), a number of
; missionaries to move (M), and a number of cannibals to move (C). It returns a
; list containing the state that results from moving that number of missionaries
; and cannibals from the current side of the river to the other side of the
; river. If applying this operator results in an invalid state (because there
; are more cannibals than missionaries on either side of the river, or because
; it would move more missionaries or cannibals than are on this side of the
; river) it returns NIL.
;
; NOTE that next-state returns a list containing the successor state (which is
; itself a list); the return should look something like ((1 1 T)).
(defun next-state (s m c)
  (cond 
    ; more cannibals than missionaries 
    ((and (< (- (car s) m) (- (cadr s) c)) (not (= (- (car s) m) 0))) NIL)
    ((and (< (+ (- 3 (car s)) m) (+ (- 3 (cadr s)) c)) (not (= (+ (- 3 (car s)) m) 0))) NIL)

    ; too many cannibals or missionaries are moved
    ((or (< (car s) m) (< (cadr s) c)) NIL)

    ; no problems with the state
    (t (list (list (+ (- 3 (car s)) m) (+ (- 3 (cadr s)) c) (not (caddr s)))))))

; SUCC-FN returns all of the possible legal successor states to the current
; state. It takes a single argument (S), which encodes the current state, and
; returns a list of states that can be reached by applying legal operators to
; the current state.
(defun succ-fn (s) 
  (append (next-state s 1 0)
          (next-state s 0 1)
          (next-state s 1 1)
          (next-state s 2 0)
          (next-state s 0 2)))

; ON-PATH checks whether the current state is on the stack of states visited by
; this depth-first search. It takes two arguments: the current state (S) and the
; stack of states visited by MC-DFS (STATES). It returns T if S is a member of
; STATES and NIL otherwise.
(defun on-path (s states) 
  (cond
    ((null states) nil)
    ((equal s (first states)) t)
    (t (on-path s (rest states)))))

; MULT-DFS is a helper function for MC-DFS. It takes two arguments: the path
; from from the initial state to the current state (PATH), and the legal
; successor states to the last state on PATH (STATES). PATH is a first-in
; first-out list of states; that is, the first element is the initial state for
; the current search and the last element is the most recent state explored.
; MULT-DFS does a depth-first search on each element of STATES in turn. If any
; of those searches reaches the final state, MULT-DFS returns the complete path
; from the initial state to the goal state. Otherwise, it returns NIL.
(defun mult-dfs (states path)
  (let ((explore-state (car states)))
    (cond ((null explore-state) nil)
          ((final-state explore-state) (append path (list explore-state)))
          (t (or (mc-dfs explore-state path) (mult-dfs (cdr states) path))))))

; MC-DFS does a depth first search from a given state to the goal state. It
; takes two arguments: a state (S) and the path from the initial state to S
; (PATH). If S is the initial state in our search, PATH should be NIL. MC-DFS
; performs a depth-first search starting at the given state. It returns the path
; from the initial state to the goal state, if any, or NIL otherwise. MC-DFS is
; responsible for checking if S is already the goal state, as well as for
; ensuring that the depth-first search does not revisit a node already on the
; search path.
(defun mc-dfs (s path) 
  (cond ((or (null s) (on-path s path)) nil)
        ((final-state s) (append path (list s)))
        (t (mult-dfs (succ-fn s) (append path (list s))))))


; Function execution examples

; Applying this operator would result in an invalid state, with more cannibals
; than missionaries on the east side of the river.
; (next-state '(3 3 t) 1 0) -> NIL

; Applying this operator would result in one cannibal and zero missionaries on
; the west side of the river, which is a legal operator. (note that NEXT-STATE
; returns a LIST of successor states, even when there is only one successor)
; (next-state '(3 3 t) 0 1) -> ((0 1 NIL))

; SUCC-FN returns all of the legal states that can result from applying
; operators to the current state.
; (succ-fn '(3 3 t)) -> ((0 1 NIL) (1 1 NIL) (0 2 NIL))
; (succ-fn '(1 1 t)) -> ((3 2 NIL) (3 3 NIL))
