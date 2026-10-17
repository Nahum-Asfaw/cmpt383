#lang tiny-lisp
;; Attempts

;; Count the # of occurrences of x in L
(define (count-acc x L n)
  (cond [(empty? L)
         n]
        [(equal? x (first L))
         (count-acc x (rest L) (+ n 1))]
        [else
         (count-acc x (rest L) n)]
        ))

(define (count x L)
  (count-acc x L 0))

;; Last element: done this
;; nth element:
(define (nth-acc x L n)
  (cond [(empty? L)
         (error "Index DNE!")]
        [(= x n)
         (first L)]
        [else
         (nth-acc x (rest L) (+ n 1))]
        ))

(define (nth x L)
  (nth-acc x L 0))

;; Remove all occurences of x from L
;; Recursive Idea:
;; - Return an emtpy list if the list is empty
;; - Else, if the first element is x, return the result of (remove x (rest L))
;; - Otherwise, return the first element followed by the result of (remove x (rest L))
(define (remove x L)
  (cond [(empty? L)
         '()]
        [(equal? x (first L))
         (remove x (rest L))]
        [else
         (cons (first L) (remove x (rest L)))]
        ))

;; Append:
;; Recursive Idea:
;; keep consing elements of A to B until A is emtpy.
(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; (concat lol) returns a new list that is the concatenation of all the lists in lol. For example,
;; (concat '((1) (two three four) (five) (6 7))) evals to '(1 two three four five 6 7).
(define (concat lol)
  (cond [(empty? lol)
         '()]
        [else
         (append (first lol) (concat (rest lol)))]
        ))

;; Reverse
;; Idea:
;; append the other way.
(define (reverse L)
  (cond[(empty? L)
       '()]
      [else
       (append (reverse (rest L)) (list (first L)))] ;; Remember to (list (...)) for stuff like this
      ))

;; reverse-acc
(define (reverse-acc L A)
  (cond [(empty? L)
         A]
        [else
         (reverse-acc (rest L) (cons (first L) A))]
        ))

(define (reverse-2 L)
  (reverse-acc L '()))

;; length and sum with acc: done

;; Map a list
;; return a new list that is the result of applying the function f to each element of the list L
(define (map f L)
  (cond [(empty? L)
         '()]
        [else
         (cons (f (first L)) (map f (rest L)))]
        ))

;; Filter a list
;; e.g., (filter even? '(1 2 3 4 5)) returns (2 4), and (filter (lambda (x) (< x 3)) '(1 2 3 4 5))
;; returns (4 5)
(define (filter p L)
  (cond [(empty? L)
         '()]
        [(p (first L))
         (cons (first L) (filter p (rest L)))]
        [else
         (filter p (rest L))]
        ))

;; All
(define (all-help p L)
  (cond [(empty? L)
        #t]
        [(p (first L))
         (all-help p (rest L))]
        [else
         #f]
        ))

(define (all p L)
  (cond [(empty? L)
         #f]
        [else
         (all-help p L)]
        ))

;; fold
(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
         (op (first L) (foldr op init (rest L)))]
        ))

;; sum as a right fold
(define (sum-f L)
  (foldr + 0 L))

;; length
(define (length-f L)
  (foldr (lambda (next x) (+ x 1)) 0 L))

;; member WHTVR
(define (member-f x L)
  (foldr (lambda (next y) (equal? next x) y) #f L))