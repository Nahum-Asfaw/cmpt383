#lang tiny-lisp
(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
         (op (first L) (foldr op init (rest L)))]
        ))

;; member-f
(define (member-f x L)
  (foldr (lambda (next acc) (or (equal? next x) acc)) #f L))


;; map-f
(define (map-f f L)
  (foldr (lambda (next acc) (cons (f next) acc)) '() L))

;; filter-f 
(define (filter-f pred? L)
  (foldr (lambda (next acc) (cond [(pred? next) (cons next acc)][else acc]))
         '() L))

;; append-f
(define (append-f A B)
  (foldr (lambda (next acc) (cons next acc)) B A))

;; append-f-tjd
(define (append-f-tjd A B)
  (foldr cons B A))

;; (foldr append '(a b c) '()) => '(a b c). Returns B immediately
;; - ----------------------------------------------------------------------------
;; insertion sort
;; unsorted     sorted
;; (4 3 1 6 2)  '()
;;   (3 1 6 2)  '(4)
;;     (1 6 2)  '(3 4)
;;       (6 2)  '(1 3 4)
;; ...
;; sorted => (1 2 3 4 6)

;; (insert-sorted x sorted-list)
(define (insertion-sort L)
  (foldr insert-sorted '() L))

(define (insert-sorted x L)
  (cond [(empty? L)
         (list x)]
        [(<= x (first L))
         (cons x L)]
        [else
         (cons (first L)(insert-sorted x (rest L)))]
        ))

;; QUICKSORT

