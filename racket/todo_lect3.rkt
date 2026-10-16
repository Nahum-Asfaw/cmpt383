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
;; nvm dude
(define (append A B)