#lang tiny-lisp

(define pi 3.14155926)

#;(define inc
    (lambda (n) (+ 1 n)))

(define (inc n)
  (+ 1 n))

(define (square x)
  (* x x))

(define (sign n)
  (cond [(not (number? n)) (error "not a number")]
        [(< n 0)          'negative]
        [(= n 0)              'zero]
        [#t               'positive]
        ))

;; Recursion:
;; - Base case: 0 if list is empty
;; - Recursive case: 1 + the length of the rest of the list

(define (length L)
  (cond [(empty? L)
         0]
        [else
         (+ 1 (length (rest L)))]
        ))

;; Recursion:
;; - Base case: 0 if list is empty
;; - Recursive case: first of list + the rest of the list

(define (sum L)
  (cond [(empty? L)
         0]
        [else
         (+ (first L)
            (sum (rest L)))]
        ))

;; Product

(define (prod L)
  (cond [(empty? L)
         1]
        [else
         (* (first L)
            (prod (rest L)))]
        ))

;; HW: Write a function called range that works like this:
;; > (range 5)
;; '(0 1 2 3 4)