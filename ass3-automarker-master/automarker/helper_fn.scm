;; Some helper functions for the automarking

(define (reduce fn base arr)
  (if (= (length arr) 0)
    base
    (reduce fn (fn base (car arr)) (cdr arr))))

(define (iota n)
  (iota-helper (- n 1) n '()))

(define (iota-helper i n lst)
  (if (= i -1)
    lst
    (iota-helper (- i 1) n (cons i lst))))
