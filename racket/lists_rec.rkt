#lang tiny-lisp

;; (cons x y) lets you combine any two values:
;; (cons 2 3)
;; > '(2 . 3)
;; (cons 'a 'b)
;; > '(a . b)
;; (cons (list 1 2 3) 'a)
;; > '((1 2 3) . a)

;; Values of the form (x . y) are called dotted pairs, or just pairs for short. pair? test if a value
;; is a pair:
;; (pair? '(1 . 2))
;; > #t
;; (pair? 'two)
;; > #f

;; a dotted pair is implemented in memory as a cons cell, a value with two pointers.

;; Lists are nested pairs. Written as pairs, '(3 4 5) has this structure:
;; '(3 . (4 .  (5 . ())))

;; list? tests if a value is a list, e.g.:
;; > (list? '(1 . 2))
;; > #f
;; > (list '(1 2))
;; > #t
;; Both '(1 . 2) and '(1 2) are pairs, but only '(1 2) is a list because it has the proper structure
;; '(1 . (2 ())).

;; Garbage Collection
;; cons creates a pair in racket, but how do you delete a pair? Racket delets it automatically using
;; garbage collection, which means that it keeps track of which pairs are in use, and automatically
;; deletes the ones that aren't.
;; Lisp was one of the first languages to use garbage collection. While this makes managing memory
;; much easier, it happens while your program is running, and so can slow your program down, or even
;; pause it. Many of the computers that that Lisp ran on in the 50s-80s were quite slow, and garbage
;; collection pauses were noticable and occured at random times, and so made it hard to use in practice.
;; But nowadays, computers are much faster and have more memory, and so garbage collection is far more
;; common. For example, python, javascript, c# and Go all use garbage collection.

;; Recursive Functions
;; Suppose we want to calculate yadda yadda done this

;; Linear seach ... done this

;; Challenge: linear search location: Using recursion, implement a function called (index-of x lst) that
;; returns the index location of the first occurence of x in ls. The first index value is 0. If x is not
;; in lst, then return -1.

;; Idea: use an acc to record the index, and return that value.
(define (index-of-acc x L i)
  (cond [(empty? L)
         -1]
        [(equal? x (first L))
         i]
        [else
         (index-of-acc x (rest L) (+ i 1))]
        ))

(define (index-of x L)
  (index-of-acc x L 0))

;; Counting: ok
;; Let's write a general-purpose counting function whose input is a list and a predicate. A predicate is a
;; function that takes one value as input and returns either #t or #f:
(define (count-fn pred? L) ;; I.e., how many #t's are there in the list for this predicate?
  (cond [(empty? L)
         0]
        [(pred? (first L))
         (+ 1 (count-fn pred? (rest L)))]
        [else
         (count-fn pred? (rest L))]
        ))

;; This can abstract prevous functions:
(define (count-symbol L)
  (count-fn symbol? L))

(define (count-number L)
  (count-fn number? L))

;; Can also do linear search 'contians?' with a predicate... done

;; CONTINUE AT IDK MAN CMON