#lang tiny-lisp

;;
;; CMPT 383: Tiny Lisp Group Practice
;;
;; Group members:
;;   1. ME
;;
;; Instructions:
;;
;; - Replace the 'todo in each function with your solution. Use only
;;   tiny-lisp features (no if, length, append, etc.).
;;
;; - Click Run. Every test line at the bottom of the file prints either
;;
;;      '(ok <expression>)
;;
;;   or
;;
;;      '(FAIL <expression> got <your answer> expected <correct answer>)
;;
;; - You're done with a problem when all of its tests print ok.
;;
;; - Don't change anything below the "TESTS" line.
;;

;;
;; Problem 1
;;
;; (count-evens L) returns how many even numbers are in the list of
;; integers L.
;;

;; Recursive idea:
;; - If the list is empty, return 0
;; - Else, count-evens (rest L) + 1 if (first L) is even (using an accumulator)
;; -    Else, count-evens (rest L)
(define (count-acc L acc)
  (cond [(empty? L)
         acc]
        [else ;; nested: if even, acc++ and increment, else just increment
         (cond [(even? (first L))
                       (count-acc (rest L) (+ acc 1))]
               [else
                (count-acc (rest L) acc)])]
        ))

(define (count-evens L)
  (count-acc L 0))

;;
;; Problem 2
;;
;; (max-of L) returns the largest number in the list L. If L is empty,
;; it raises an error.
;;

;; cond [(< x (first L))
;;              (let* [(x (first L))]
;;                 (max-of (rest L) x))]
;;
;; using acc again
(define (max-acc L x)
  (cond[(empty? L)
        x]
       [(< x (first L))
        (let* [(x (first L))]
          (max-acc (rest L) x))]
       [else
        (max-acc (rest L) x)]
       ))
       
(define (max-of L)
  (cond [(empty? L)
         (error "empty input list!")]
        [else
         (max-acc L -100000)]
        ))

;;
;; Problem 3
;;
;; (zip A B) returns a list of 2-element lists that pair up the
;; corresponding elements of A and B. If one list is longer than the
;; other, the extra elements are ignored.
;;

;; I'll need append as a helper function for my implementation...
(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

(define (zip-help A B acc)
  (cond [(empty? A)
         acc]
        [(empty? B)
         acc]
        [else ;; Make V the new list that has ((first A) (first B))
           (zip-help (rest A) (rest B) (append acc (list (list (first A) (first B)))))]
        ))

(define (zip A B)
  (zip-help A B '()))

;;
;; Problem 4
;;
;; (sorted? L) returns #t if the numbers in L are in ascending order
;; (duplicates are allowed), and #f otherwise. The empty list and lists
;; with one element are sorted.
;;

;; ez
(define (sorted-acc L x)
  (cond [(empty? L)
         #t]
        [(> x (first L))
         #f]
        [else
         (sorted-acc (rest L) (first L))]
        ))
         

(define (sorted? L)
  (sorted-acc L -100000))

;;
;; Problem 5
;;
;; (range n) returns the list (0 1 2 ... n-1). Assume n is a
;; non-negative integer.
;;

;; ez
(define (range-acc n x)
  (cond [(>= x n)
        '()]
        [else
         (cons x (range-acc n (+ x 1)))]
        ))

(define (range n)
  (range-acc n 0))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; TESTS: don't change anything below this line
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (check expr actual expected)
  (cond [(equal? actual expected) (list 'ok expr)]
        [else (list 'FAIL expr 'got actual 'expected expected)]))

;; Problem 1: count-evens
(check '(count-evens '())            (count-evens '())            0)
(check '(count-evens '(1 3 5))       (count-evens '(1 3 5))       0)
(check '(count-evens '(2))           (count-evens '(2))           1)
(check '(count-evens '(1 2 3 4 6))   (count-evens '(1 2 3 4 6))   3)
(check '(count-evens '(-2 0 7))      (count-evens '(-2 0 7))      2)

;; Problem 2: max-of
;; (also try (max-of '()) in the interactions window: it should raise an error)
(check '(max-of '(5))                (max-of '(5))                5)
(check '(max-of '(3 9 2 7))          (max-of '(3 9 2 7))          9)
(check '(max-of '(9 3 2))            (max-of '(9 3 2))            9)
(check '(max-of '(2 3 9))            (max-of '(2 3 9))            9)
(check '(max-of '(-4 -1 -8))         (max-of '(-4 -1 -8))         -1)
(check '(max-of '(4 4 4))            (max-of '(4 4 4))            4)
(check '(max-of '(1/3 1/2 1/4))      (max-of '(1/3 1/2 1/4))      1/2)

;; Problem 3: zip
(check '(zip '() '())                (zip '() '())                '())
(check '(zip '(a b c) '(1 2 3))      (zip '(a b c) '(1 2 3))      '((a 1) (b 2) (c 3)))
(check '(zip '(a b c) '(1))          (zip '(a b c) '(1))          '((a 1)))
(check '(zip '() '(1 2))             (zip '() '(1 2))             '())
(check '(zip '(x (y z)) '((1 2) 3))  (zip '(x (y z)) '((1 2) 3))  '((x (1 2)) ((y z) 3)))

;; Problem 4: sorted?
(check '(sorted? '())                (sorted? '())                #t)
(check '(sorted? '(5))               (sorted? '(5))               #t)
(check '(sorted? '(1 2 3))           (sorted? '(1 2 3))           #t)
(check '(sorted? '(1 2 2 5))         (sorted? '(1 2 2 5))         #t)
(check '(sorted? '(-3 -1 0 1/2))     (sorted? '(-3 -1 0 1/2))     #t)
(check '(sorted? '(3 1 2))           (sorted? '(3 1 2))           #f)
(check '(sorted? '(1 2 3 0))         (sorted? '(1 2 3 0))         #f)

;; Problem 5: range
(check '(range 0)                    (range 0)                    '())
(check '(range 1)                    (range 1)                    '(0))
(check '(range 2)                    (range 2)                    '(0 1))
(check '(range 5)                    (range 5)                    '(0 1 2 3 4))
