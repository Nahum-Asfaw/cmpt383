#lang tiny-lisp
;; (reverse L)
;; Idea: idk
(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

(define (reverse L)
  (cond [(empty? L)
         '()]
        [else
         (append (reverse (rest L)) (list (first L)))]
        ))
;;----------------------------------------------------------------------------------
(define (reverse-acc L Acc)
  (cond [(empty? L)
         Acc]
        [else
         (reverse-acc (rest L) (append (list (first L)) Acc))] ;; O(1) for each element,
                                                               ;; O(n) for L of size n.
        ))

(define (reverse2 L)
  (reverse-acc L '()))
;;----------------------------------------------------------------------------------
(define (length-acc L n)
  (cond [(empty? L)
         n]
        [else
         (length-acc (rest L) (+ n 1))]
        ))

(define (length2 L)
  (length-acc L 0))
;;-----------------------------------------------------------------------------------
(define (map f L)
  (cond [(empty? L)
         '()]
        [else
         (cons (f (first L)) (map f (rest L)))]
        ))
;;-----------------------------------------------------------------------------------
(define (filter pred? L)
  (cond [(empty? L)
         '()]
        [(pred? (first L))
         (cons (first L) (filter pred? (rest L)))]
        [else
         (filter pred? (rest L))]
        ))
;;----------------------------------------------------------------------------------
(define (all pred? L)
  (cond [(empty? L)
         #t]
        [else
         (and (pred? (first L))
              (all pred? (rest L)))]
        ))
;;----------------------------------------------------------------------------------
(define (none pred? L)
  (all (negate pred?) L))

(define (negate pred?)
  (lambda (x) (not (pred? x))))
;;----------------------------------------------------------------------------------
;; (op a (op b (op c (op d init))))
(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
        (op (first L) (foldr op init (rest L)))]
        ))

(define (sum-f L)
  (foldr + 0 L))

(define (factorial-f L)
  (foldr * 1 L))

(define (length-f L)
  (foldr (lambda (rest x) (+ x 1)) 0 L))

#;(define (member-f L)
  (foldr (lambda (next x) (or (equal? x 