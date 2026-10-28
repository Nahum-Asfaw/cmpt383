#lang tiny-lisp

(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
         (op (first L) (foldr op init (rest L)))]
        ))

;; Q1
(define (almost-last L)
  (cond [(or (empty? L) (empty? (rest L))) ;; '() or |L| = 1
         'none]
        [(empty? (rest (rest L)))          ;; |L| = 2
         (first L)]
        [else                              ;; |L| > 2
         (almost-last (rest L))]
        ))

;; Q2
(define (drop-if pred? L)
  (foldr (lambda (next acc) (cond [(pred? next)
                                   acc]
                                  [else
                                   (cons next acc)]))
         '()
         L))