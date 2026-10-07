#lang tiny-lisp
;; Functions to Know
;; The following functions are all useful for working with lists, and are good practice
;; for writing recursive functions in LISP.

;; Length of a list:
;; (length L) returns the number of elements in the list L. The recursive idea is:
;; - return 0 if the list is empty
;; - otherwise, return 1 plus the length of the rest of the list

(define (length L)
  (cond [(empty? L) 0]
        [else
         (+ 1
            (length (rest L)))]
        ))

;; Sum and Product of a list
;; The sum and product of a list are conceptually similar to the length of a list. To
;; calculate the sum of a list, the recursive idea is:
;; - return 0 if the list is empty
;; - otherwise, return the first element plus the sum of the rest of the list

(define (sum L)
  (cond [(empty? L) 0]
        [else (+ (first L)
                 (sum (rest L)))]
        ))

(define (product L)
  (cond [(empty? L) 1]
        [else (* (first L)
                 (product (rest L)))]
        ))

;; Member of a list
;; (member? x L) returns #t if x is an element in L, #f otherwise. The recursive idea is:
;; - return #f if the list is empty
;; - else, return #t if its first element is x
;;         - otherwise, return the result of (member? x (rest of L))

(define (member? x L)
  (cond [(empty? L)
         #f]
        [(equal? x (first L))
         #t]
        [else (member? x (rest L))]
        ))

;; Count Occurrenes
;; (count x L) returns the number of occurrences of x in the list L. The recursive idea is:
;; - return 0 if the list is empty
;; - else, if x is the first element of L, return 1 plus the count of x in the rest of L
;; - otherwise, return the count of x in the rest of L

(define (last L)
  (cond [(empty? L)
         (error "last: empty list")]
        [(empty? (rest L))
         (first L)]
        [else
         (last (rest L))]
        ))

;; nth Element
;; (nth n L) returns the item at index location n in the list L. Let's make the indexing
;; zero-based, so the first element is at index 0, the second element is at index 1, etc.
;; The recursive implementation idea is:
;; - return an error if the list is empty, or if n is negative
;; - else, if n is 0, return the first element of the list
;; - otherwise, return the item at index n-1 in the rest of the list

(define (nth n L)
  (cond [(empty? L)
        (error "nth: index out of range")]
        [(< n 0)
         (error "nth: negative index")]
        [(= n 0)
         (first L)]
        [else
         (nth (- n 1) (rest L))]
        ))

;; Remove all occurences of an element from a list
;; (remove x L) returns a new list with all occurrences of x removed from list L. The
;; recursive idea is:
;; - return an emtpy list if the list is empty
;; - else, if the first element is x, return the result of (remove x (rest L))
;; - otherwise, return the first element followed by the result of (remove x (rest L))

(define (remove_all x L)
  (cond [(empty? L)
         '()]
        [(equal? x (first L))
         (remove_all x (rest L))]
        [else
         (cons (first L) (remove_all x (rest L)))]
        ))

;; Append two lists
;; (append A B) returns a new list that is the concatenation of the lists A and B. The
;; recursive idea is:
;; - return B if A is empty
;; - Otherwise, return the first element of A followed by the result of (append (rest A) B)
(define (append A B)
  (cond [(empty? A)
        B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; Append all lists in a list
;; (concat list-of-lists) returns a new list that is the concatenation of all lists in
;; list-of-lists. The recursive idea is:
;; - return an empty list if list-of-lists is empty
;; - otherwise, append the first list of list-of-lists to the result of
;; - (concat (rest list-of-lists))

(define (concat list-of-lists)
  (cond [(empty? list-of-lists)
         '()]
        [else
         (append (first list-of-lists)
                 (concat (rest list-of-lists)))]
        ))

;; Reserve a list
;; (resurve L) returns a ...