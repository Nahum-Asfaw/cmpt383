#lang tiny-lisp
(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; insertion sort

;; insert x into L
(define (insert x L) ;; returns new L with x inserted
  (cond [(empty? L)
         (list x)]
        [(< x (first L))
         (cons x L)]
        [else
         (cons (first L) (insert x (rest L)))]
        ))

(define (insertion-sort L acc)
  (cond [(empty? L)
         acc]
        [else
         (insertion-sort (rest L) (insert (first L) acc))]
        ))


(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
         (op (first L) (foldr op init (rest L)))]
        ))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (I x)
 x)

(define (M x)
  (x x))

(define (K x)
  (lambda (y) x))

(define (compose-all L)
  (foldr compose I L))

(define (f x) (append x (list 'f)))
(define (g x) (append x (list 'g)))
(define (h x) (append x (list 'h)))

(define fgh (compose-all (list f g h)))

(define (reverse-acc L acc)
  (cond [(empty? L)
         acc]
        [else
         (reverse-acc (rest L)
                      (cons (first L) acc))]
        ))

(define (reverse L)
  (reverse-acc L '()))

(define (pipeline L)
  (compose-all (reverse L)))

(define seq2 (pipeline (list f g h)))

;; currry2
(define (curry2 f)
  (lambda (x)
    (lambda (y)
      (f x y))))

;; deep-map-f
(define (deep-map-f f L)
  (foldr (lambda (next acc) (cons (cond [(list? next) (deep-map-f f next)]
                                  [else         (f next)]
                                  )
                                  acc))
         '()
         L))
