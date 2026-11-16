#lang tiny-lisp
(define (take-h n lst i)
  (cond [(empty? lst)
         '()]
        [(= n i)
         '()]
        [else
         (cons (first lst) (take-h n (rest lst) (+ i 1)))]
        ))

(define (take n lst)
  (cond [(> 0 n)
         '()]
        [else
         (take-h n lst 0)]
        ))