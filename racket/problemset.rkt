#lang tiny-lisp
(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; Q1
(define (index-of-acc x L acc)
  (cond [(empty? L)
         -1]
        [(equal? x (first L))
         acc]
        [else
         (index-of-acc x (rest L) (+ acc 1))]
        ))

(define (index-of x L)
  (index-of-acc x L 0))

;; Q2
;; Need to do linear search, i.e., start with A[0], go through B.
;; If it exists, reset with A[1], go through B.
;; if A = '(), return #t
;; Else, return #f
(define (my-subset-curr? A B curr)
  (cond [(empty? A)
         #t]
        [(empty? curr)
         #f]
        [(equal? (first A) (first curr))
         (my-subset-curr? (rest A) B B)]
        [else
         (my-subset-curr? A B (rest curr))]
        ))

(define (my-subset? A B)
  (my-subset-curr? A B B))

;; Q3
;; Want to hold a reconstructed list where you search if this element already exist,
;; and if it does don't cons it. O(n**2)...

;; helper
(define (exists? x L)
  (cond [(empty? L)
         #f]
        [(equal? x (first L))
         #t]
        [else
         (exists? x (rest L))]
        ))

(define (my-remove-duplicates-h L acc)
  (cond [(empty? L)
         acc]
        [(exists? (first L) acc)
         (my-remove-duplicates-h (rest L) acc)]
        [else
         (my-remove-duplicates-h (rest L) (append acc (list (first L))))]
        ))

(define (my-remove-duplicates L)
  (my-remove-duplicates-h L '()))

;; Q4
;; A consed-out list is a representation of a list uisng nested calls to cons. For example, yadda yadda
;; Implement a function that does that.
;;
;; If (first L) is a list, do (rest (first L))
(define (make-consed L)
  (cond [(empty? L)
         '()]
        [(list? (first L))
         (list 'cons (make-consed (first L)) (make-consed (rest L)))]
        [else
         (list 'cons (first L) (make-consed (rest L)))]
        ))

;; Q5

;; 1)
(define (my-map f L)
  (cond [(empty? L)
         '()]
        [else
         (cons (f (first L)) (my-map f (rest L)))]
        ))

;; 2)
(define (my-filter p? L)
  (cond [(empty? L)
         '()]
        [(p? (first L))
         (cons (first L) (my-filter p? (rest L)))]
        [else
         (my-filter p? (rest L))]
        ))

;; 3)
(define (my-foldr f init L)
  (cond [(empty? L)
         init]
        [else
         (f (first L) (my-foldr f init (rest L)))]
        ))


;; foldr test
(define (reverse-f L)
  (my-foldr (lambda (next acc) (append acc (list next))) '() L))

;; Q6
(define (filter-f p? L)
  (my-foldr (lambda (next acc) (cond [(p? next) (cons next acc)] [else acc])) '() L))

;; Q7
;; currying is when a func takes a func and does one op over idr...
;; "The idea of currying is to treat a function that takes more than 1 input as a series of functions that
;; take 1 input each"

(define (curry2 f) ;; takes 2 args
  (lambda (x) (lambda (y) (f x y))))

(define (add x y)
  (+ x y))

(define c_add (curry2 add))

;; > ((c_add 3) 2)
;; 5

;; Q8
;; a)
(define (I x) x)
(define (M x) (x x))
(define (K x) (lambda (y) x))
(define (S3 x y z) ((x z) (y  z)))

;; b)
;; As mentioned in the lect,
;; I == S K K for a curried S. However, we weren't showed an implementation of S using currying,
;; so idk how to implelemnt this.

;; Q9)
;; Assumptions:
;; - only error is that the first term != if
;; not sure on the 'if' clause: assume the statement has 3 terms,
;; (first L) = cond, (second L) = case, (third L) = if case, (fourth L) = result case
(define (second L)
  (first (rest L)))
(define (third L)
  (first (rest (rest L))))
(define (fourth L)
  (first (rest (rest L))))

(define (if-to-cond L)
  (list 'cond (list (second L) (third L)) (list 'else (fourth L)))
  )

;; Q10
;; Not doing Macros
;; DONE !!!