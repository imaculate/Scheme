;; Comparison function checks that given output is exactly equal to expected output
(load "automarker/helper_fn.scm")
(define (exactly-equal expected-output)
    (lambda (actual-output) (equal? actual-output expected-output))
)

;; Checks that output is true
(define (assert-true)
    (lambda (actual-output) (equal? actual-output #t))
)

;; Checks that output is false
(define (assert-false)
    (lambda (actual-output) (equal? actual-output #f))
)

;; Checks that a list of states and corresponding move histories are equivalent
(define (state-list-equal expected-output)
    (lambda (actual-output)
            (if (check-states-lengths expected-output actual-output)
                (all (map 
                    (lambda (i)
                        (let ((expected-state (list-ref (car expected-output) i))
                              (expected-moves (list-ref (cadr expected-output) i)))
                            (check-state-match expected-state expected-moves actual-output) 
                        )
                    )
                    (iota (length (car expected-output)))
                ))              
                #f
            )
    )
)

;; Helper function for state-list-equal, determine if a given state and move are in the given list of states and they in the same positions
(define (check-state-match expected-state expected-moves actual-output)
     (and (member expected-state (car actual-output))
          (member expected-moves (cadr actual-output)))
)

;; Helper function for state-list-equal, checks that the expected and actual states match in lengths
(define (check-states-lengths expected-states actual-states)
    (all (list 
        (equal? (length actual-states) 2)
        (equal? (length (car expected-states)) (length (car actual-states)))
        (equal? (length (cadr expected-states)) (length (cadr actual-states)))
)))

;;  Helper function, checks that all the entries in a list are true
(define (all ls)
    (reduce 
        (lambda (a b) (and a b))
        #t
        ls)
)
