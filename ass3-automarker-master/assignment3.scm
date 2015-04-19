;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functional Programming Assignment --- Fixing The World    ;;
;; 25/3/15                                                   ;;
;; <Imaculate Mosha , MSHIMA001>   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;-------------------HELPER FUNCTIONS----------------------
;; ;print function for debugging purposes
(define (print . args)
  (cond ((not (null? args))
        (display (car args))
        (apply print (cdr args)))
  )
)

;; ;gets nth index of 0-indexed list. Can use list-ref instead
(define (index lst idx)
    (if (null? lst)
        lst
        (if (= idx 0)
            (car lst)
            (index (cdr lst) (- idx 1))
        )
    )
)
;; ;TESTS
;; ; (print (= 1 (index '(1 2 3 4 5) 0)) "\n")
;; ; (print (= 4 (index '(1 2 3 4 5) 3)) "\n")
;; ; (print (not (= 1 (index '(1 2 3 4 5) 2))) "\n")
;; ; (print (not (= 0 (index '(1 2 3 4 5) 0))) "\n")

;; ;checks if an item is in a list
;; You might want to do a more efficient version of this.
;;
(define (in item lst)
    (if (null? lst)
        #f
        (if (equal? item (car lst))
            #t
            (in item (cdr lst))
        )
    )
)
;; ;TESTS
;; ; (print (in 1 '(1 2 3)) "\n")
;; ; (print (in 2 '(1 2 3)) "\n")
;; ; (print (not (in 4 '(1 2 3))) "\n")
;; ; (print (in '(1 2) '((1 2) (3 4) 5)) "\n")

;; ;helper function for finding the length of a list
(define (lengthHelper n lst)
    (if (null? lst)
        n
        (lengthHelper (+ n 1) (cdr lst))
    )
)

;; ;finds length of a list
(define (length lst)
    (lengthHelper 0 lst)
)
;; ;TESTS
;; ; (print (= 4 (length '(1 2 3 4))) "\n")
;; ; (print (= 1 (length '(1))) "\n")
;; ; (print (= 2 (length '((1 2) (3 4)))) "\n")
;; ; (print (not (= 4 (length '(1 2 3 4 5)))) "\n")
;; ;-----------------------------------------------------------


;---------------------SOLVED STATES------------------------
;solved states of a 2x2x2 rubiks cube
(define solvedStates
    '(  ((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))
        ((3 1) (1 1) (4 1) (2 1) (7 3) (5 3) (8 3) (6 3))
        ((4 1) (3 1) (2 1) (1 1) (8 3) (7 3) (6 3) (5 3))
        ((2 1) (4 1) (1 1) (3 1) (6 3) (8 3) (5 3) (7 3))

        ((5 5) (1 6) (7 5) (3 6) (6 5) (2 6) (8 5) (4 6))
        ((7 5) (3 6) (8 5) (4 6) (5 5) (1 6) (6 5) (2 6))
        ((8 5) (4 6) (6 5) (2 6) (7 5) (3 6) (5 5) (1 6))
        ((6 5) (2 6) (5 5) (1 6) (8 5) (4 6) (7 5) (3 6))

        ((2 5) (6 6) (4 5) (8 6) (1 5) (5 6) (3 5) (7 6))
        ((4 5) (8 6) (3 5) (7 6) (2 5) (6 6) (1 5) (5 6))
        ((3 5) (7 6) (1 5) (5 6) (4 5) (8 6) (2 5) (6 6))
        ((1 5) (5 6) (2 5) (6 6) (3 5) (7 6) (4 5) (8 6))

        ((7 1) (8 1) (5 1) (6 1) (3 3) (4 3) (1 3) (2 3))
        ((5 1) (7 1) (6 1) (8 1) (1 3) (3 3) (2 3) (4 3))
        ((6 1) (5 1) (8 1) (7 1) (2 3) (1 3) (4 3) (3 3))
        ((8 1) (6 1) (7 1) (5 1) (4 3) (2 3) (3 3) (1 3))

        ((3 2) (4 2) (7 4) (8 4) (1 2) (2 2) (5 4) (6 4))
        ((1 2) (3 2) (5 4) (7 4) (2 2) (4 2) (6 4) (8 4))
        ((2 2) (1 2) (6 4) (5 4) (4 2) (3 2) (8 4) (7 4))
        ((4 2) (2 2) (8 4) (6 4) (3 2) (1 2) (7 4) (5 4))

        ((5 2) (6 2) (1 4) (2 4) (7 2) (8 2) (3 4) (4 4))
        ((7 2) (5 2) (3 4) (1 4) (8 2) (6 2) (4 4) (2 4))
        ((8 2) (7 2) (4 4) (3 4) (6 2) (5 2) (2 4) (1 4))
        ((6 2) (8 2) (2 4) (4 4) (5 2) (7 2) (1 4) (3 4))
    )
)
;; ;-----------------------------------------------------


;; ;---------------------QUESTION 1.1-----------------------
;; ;helper function for rotating the cube. Recalculates the various orientations
;; ;of the sub-cubes
(define (recalculateOrientation orientation axis)
    (cond
        [(= axis 0)
            (if (> orientation 4)
                orientation
                (if(= orientation 4)
                    1
                    
                    (+ orientation 1)
                )
            )
        ]
        [(= axis 1) 
            (if (or (= orientation 1) (= orientation 3))
                orientation
                (cond
                    [(= orientation 2) 6]
                    [(= orientation 4) 5]
                    [(= orientation 5) 2]
                    [(= orientation 6) 4]
                )
            )
        ]
        [(= axis 2)
            (if (or (= orientation 2) (= orientation 4))
                orientation
                (cond
                    [(= orientation 1) 5]
                    [(= orientation 3) 6]
                    [(= orientation 5) 3]
                    [(= orientation 6) 1]
                )
            )
        ]
        
        [(= axis 3)
            
            (recalculateOrientation (recalculateOrientation (recalculateOrientation orientation 0) 0) 0)
           
        ]
        
        [(= axis 4)
             (recalculateOrientation (recalculateOrientation (recalculateOrientation orientation 1) 1) 1)
         ]
        [(= axis 5)
             (recalculateOrientation (recalculateOrientation (recalculateOrientation orientation 2) 2) 2)
         ]



    )
)
;; ;TESTS
;; ; (print (= 2 (recalculateOrientation 1 0)) "\n")
;; ; (print (= 5 (recalculateOrientation 5 0)) "\n")
;; ; (print (= 1 (recalculateOrientation 1 1)) "\n")
;; ; (print (= 6 (recalculateOrientation 2 1)) "\n")
;; ; (print (= 5 (recalculateOrientation 1 2)) "\n")
;; ; (print (= 2 (recalculateOrientation 2 2)) "\n")

;rotations are performed using the left hand rule
;rotates left 4 cubes along x axis

( define original  '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)))
(define (rotateX ispositive state)
	;(list '((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3)) (list "x")) ;;; *TODO* ;;;
 
   
   (if (eqv? ispositive #t) 
        (list (list (list (car (list-ref state 4))  (recalculateOrientation  (car (cdr (list-ref state 4))) 0))
                          (list-ref state 1)
                          (list (car (list-ref state 0))  (recalculateOrientation   (car  (cdr (list-ref state 0))) 0))
                          (list-ref state 3)
                          (list (car (list-ref state 6))  (recalculateOrientation   (car (cdr (list-ref state 6))) 0))
                          (list-ref state 5)
                         (list (car (list-ref state 2))  (recalculateOrientation   (car (cdr (list-ref state 2))) 0))
                          (list-ref state 7)
                          )(list "x"))
                          
                    (list (list (list (car (list-ref state 2))  (recalculateOrientation   (car (cdr (list-ref state 2))) 3))
                          (list-ref state 1)
                          (list (car (list-ref state 6))  (recalculateOrientation   (car (cdr (list-ref state 6))) 3))
                          (list-ref state 3)
                          (list (car (list-ref state 0))  (recalculateOrientation   (car (cdr (list-ref state 0))) 3))
                          (list-ref state 5)
                         (list (car (list-ref state 4))  (recalculateOrientation   (car (cdr (list-ref state 4))) 3))
                          (list-ref state 7)
                          )(list "X"))
   

	
	
)
)


;rotates bottom 4 cubes along y axis
(define (rotateY ispositive state)
   	;(list '((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3)) (list "y")) ;;; *TODO* ;;;
         (if (eqv? ispositive #t) 
                           (list (list (list-ref state 0)
                          (list-ref state 1)
                          (list-ref state 2)
                          (list-ref state 3)
                          (list (car (list-ref state 5))  (recalculateOrientation   (car (cdr (list-ref state 5))) 1))
                          (list (car (list-ref state 7))  (recalculateOrientation   (car (cdr (list-ref state 7))) 1))
                         (list (car (list-ref state 4))  (recalculateOrientation   (car (cdr (list-ref state 4))) 1))
                          (list (car (list-ref state 6))  (recalculateOrientation   (car (cdr (list-ref state 6))) 1))
                          )(list "y"))
                          
                    (list (list (list-ref state 0)
                          (list-ref state 1)
                          (list-ref state 2)
                          (list-ref state 3)
                          (list (car (list-ref state 6))  (recalculateOrientation   (car (cdr (list-ref state 6))) 4))
                          (list (car (list-ref state 4))  (recalculateOrientation   (car (cdr (list-ref state 4))) 4))
                         (list (car (list-ref state 7))  (recalculateOrientation   (car (cdr (list-ref state 7))) 4))
                          (list (car (list-ref state 5))  (recalculateOrientation   (car (cdr (list-ref state 5))) 4))
                          )(list "Y"))
   

	
	)
)
	;if positive 5-4-6-7-5, else, 5-7-6-4-5,
	; orientation for X = xxx;


;rotates back 4 cubes along z axis
(define (rotateZ ispositive state)
	;(list '((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3)) (list "z")) ;;; *TODO* ;;;
         (if (eqv? ispositive #t) 
                          (list (list (list (car (list-ref state 1))  (recalculateOrientation   (car (cdr (list-ref state 1))) 2))
                           (list (car (list-ref state 5))  (recalculateOrientation   (car (cdr (list-ref state 5))) 2))                         
                          (list-ref state 2)
                          (list-ref state 3)
                          (list (car (list-ref state 0))  (recalculateOrientation   (car (cdr (list-ref state 0))) 2))
                          (list (car (list-ref state 4))  (recalculateOrientation   (car (cdr (list-ref state 4))) 2))
                          (list-ref state 6)
                           (list-ref state 7)
                          )(list "z"))
                          
                   (list (list (list (car (list-ref state 4))  (recalculateOrientation   (car (cdr (list-ref state 4))) 5))
                           (list (car (list-ref state 0))  (recalculateOrientation   (car (cdr (list-ref state 0))) 5))                         
                          (list-ref state 2)
                          (list-ref state 3)
                          (list (car (list-ref state 5))  (recalculateOrientation   (car (cdr (list-ref state 5))) 5))
                          (list (car (list-ref state 1))  (recalculateOrientation   (car (cdr (list-ref state 1))) 5))
                          (list-ref state 6)
                           (list-ref state 7)
                          )(list "Z"))
   

	
	
)
	
)
      

;; ;helper for rotate function
(define (rotateHelper char state)
    (cond
        [(char=? char #\x) (car (rotateX #t state))]
        [(char=? char #\X) (car (rotateX #f state))]
        [(char=? char #\y) (car (rotateY #t state))]
        [(char=? char #\Y) (car (rotateY #f state))]
        [(char=? char #\z) (car (rotateZ #t state))]
        [(char=? char #\Z) (car (rotateZ #f state))]
    )
)

;; ;parses a string for rotations
(define (rotate rotations state)
    (if (= (string-length rotations) 0)
        state
        (rotate (substring rotations 1 (string-length rotations)) (rotateHelper (string-ref rotations 0) state))
    )
)
;; ;TESTS
;; ;(print (equal? (rotate "x" '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) (car (rotateX #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))) "\n")
;; ; (print (equal? (rotate "xyz" '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) (car (rotateZ #t (car (rotateY #t (car (rotateX #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))))))) "\n")
;; ; (print (equal? (rotate "xXx" '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) (car (rotateX #t (car (rotateX #f (car (rotateX #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))))))) "\n")
;; ; (print (equal? (rotate "yXz" '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) (car (rotateZ #t (car (rotateX #f (car (rotateY #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))))))) "\n")
;; ; (print (not (equal? (rotate "xXy" '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) (car (rotateX #f (car (rotateZ #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)))))))) "\n")
;; ;------------------------------------------------------------

;-----------------------QUESTION 1.2-----------------------
;generates the successor states of the current given rubiks cube state
(define (generateSuccessorStates state prevMoves) 
    (list
        (list
            (rotate "x" state)
            (rotate "X" state)
            (rotate "y" state)
            (rotate "Y" state)
            (rotate "z" state)
            (rotate "Z" state)
            
         )
        (list (append  prevMoves (list "x")) (append  prevMoves (list "X")) (append  prevMoves (list "y")) (append  prevMoves (list "Y")) (append  prevMoves (list "z")) (append  prevMoves (list "Z")))
        )
        
    
)

;; ;TESTS
;; ; (print (equal? (generateSuccessorStates '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3)) '())
;; ;         (list
;; ;             (list
;; ;                 (car (rotateX #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))
;; ;                 (car (rotateX #f '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))
;; ;                 (car (rotateY #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))
;; ;                 (car (rotateY #f '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))
;; ;                 (car (rotateZ #t '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))
;; ;                 (car (rotateZ #f '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))))
;; ;             )
;; ;             '(("x") ("X") ("y") ("Y") ("z") ("Z"))
;; ;         )
;; ;     )
;; ; "\n")


;-----------------------------QUESTION 2.1--------------------------

;finds all the states at a specific depth
(define (loopresult i res-length res origin  )
         (if (= i res-length)
              res
             (let ((gen (generateSuccessorStates (list-ref (car origin) i) (if (null? (car (cdr origin))) '() (list-ref (car (cdr origin)) i  )
            )  
             ))) 
             (loopresult  (+ i 1) res-length  
             (list (append (car res) (car gen) ) (append (if (null? (cdr res)) '() (car (cdr res))) (car (cdr gen)) )) 
              origin)   
 )
 )
 )        
(define (genHelper d result)
   (if(= d 0)
      result
      (genHelper (- d 1)  (loopresult 0 (length (car result))  (list '() '())  result ))
    )
 )
(define (genStates n state moves)
      (genHelper  n (list (list state) (list (list)))  )
     
            
      
      
    ;((((5 4) (2 1) (1 2) (4 1) (7 4) (6 3) (3 2) (8 3)) ((3 4) (2 1) (7 2) (4 1) (1 4) (6 3) (5 2) (8 3)) ((1 1) (2 1) (3 1) (4 1) (6 3) (8 3) (5 3) (7 3)) ((1 1) (2 1) (3 1) (4 1) (7 3) (5 3) (8 3) (6 3)) ((2 5) (6 6) (3 1) (4 1) (1 5) (5 6) (7 3) (8 3)) ((5 5) (1 6) (3 1) (4 1) (6 5) (2 6) (7 3) (8 3))) ((x) (X) (y) (Y) (z) (Z))) ;;; *TODO* ;;;
	
)

;----------------------------------------------------------


;---------------------------QUESTION 3.1-----------------------
;Solves a rubiks cube using breadth first search. Can solve up to roughly 7 moves.

(define (findx x ls i)
       ( if (or (= i (length ls)) (equal? (list-ref ls i) x) )
         i
         (findx x ls (+ 1 i))
        )   
      
)
(define (loopsolved j  gen)
         (if (or (= j (length (car gen))) (not (=  (length solvedStates)(findx (list-ref (car gen) j) solvedStates 0))) )
               j
               (loopsolved (+ j 1) gen)
           )
)
            
(define (solveCube solved initial n)
   (let ((gen (genStates n initial '())))
        (let ((index (loopsolved 0  gen)))

      (if (< index (length (car gen)))
            (list-ref (car (cdr gen)) index) 
            (solveCube solvedStates initial  (+ n 1))
       ))
       )  
          
    ;'("Z", "Y", "X") ;;; *TODO* ;;;
)
;assert n<6
(define test (rotate "xyz" original))


;---------------------------------------------------------------------
;TESTS
; (print (equal? '("Z" "Y" "X") (solveCube solvedStates (rotate "xyz" '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) 0)) "\n")
; (print (equal? '("X") (solveCube solvedStates (rotate "x" '((1 1) (2 1) (3 1) (4 1) (5 3) (6 3) (7 3) (8 3))) 0)) "\n")
;---------------------------------------------------------------------

