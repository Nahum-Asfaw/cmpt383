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
        [(< n 0)
         'negative]
        [(= n 0)
         'zero]
        [#t
         'positive]
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

;; Recursion:
;; - Base case: 
(define (range-acc n x)
  (cond [(>= x n)
         '()]
        [else
         (cons x (range-acc n (+ x 1)))]
        ))

(define (range n)
  (range-acc n 0))

;; member:
(define (member? x L)
  (cond [(empty? L)
         #f]
        [(equal? x (first L))
         #t]
        [else
         (member? x (rest L))]
        ))

;; (last l)
;; returns the final (top-level) element of l

(define (last L)
  (cond [(empty? L)
         '()]
        [else
         (cond [(empty? (rest L))
               (first L)]
               [else
                (last (rest L))]
               )]
        ))

;; (remove-all x L)
;; remove all instances of L without x
(define (remove-all x L)
  (cond [(empty? L)
         '()]
        [(equal? x (first L))
         (remove-all x (rest L))]
        [else
         (cons (first L) (remove-all x (rest L)))]
        ))
        
;; append
(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; concat
;; returns a new list that consists of all the elements of the lists on
;; list-of-lists
;; > (concat '((1 2) (three four five) (six) (7 8)))
;; > '(1 2 three four fie six 7 8)
(define (concat lol)
  (cond [(empty? lol)
         '()]
        [else
         (append (first lol) (concat (rest lol)))]
        ))