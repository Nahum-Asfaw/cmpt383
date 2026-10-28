#lang tiny-lisp

;; Example; Object-oriented programming with closures
;; using closures, it's possible to simulate object-oriented programming. A clousre can contain both
;; functions and variables, as in this example:
(define (second L)
  (first (rest L)))
(define (third L)
  (first (rest (rest L))))
(define (fourth L)
  (first (rest (rest (rest L)))))


;; (set! x val) assigns val to x, i.e., it actually
;; changes what x refers to
(define (set! x val)
  ;; ??
  )

(define (make-counter name)
  (let ([n
        0])
    (list (lambda (a) (set! n (+ a n))) ;; setter
          (lambda () n)                 ;; getter
          (lambda (n) (set! name n))    ;; setter
          (lambda () name)              ;; getter
          )))

(define object (make-counter "num frogs"))

(define add (first object))
(define show-count (second object))
(define set-name (third object))
(define show-name (fourth object))