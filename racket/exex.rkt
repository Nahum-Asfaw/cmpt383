#lang tiny-lisp
;; p1 count-evens
(define (count-evens-acc L acc)
  (cond [(empty? L)
         acc]
        [(even? (first L))
         (count-evens-acc (rest L) (+ acc 1))]
        [else
         (count-evens-acc (rest L) acc)]
        ))

(define (count-evens L)
  (count-evens-acc L 0))

;; p2 max of
(define (max-of-acc L acc)
  (cond [(empty? L)
         acc]
        [(> (first L) acc)
         (max-of-acc (rest L) (first L))]
        [else
         (max-of-acc (rest L) acc)]
        ))

(define (max-of L)
  (max-of-acc L -999999999))

;; p3 zip
(define (zip A B)
  (cond [(or (empty? A) (empty? B))
         '()]
        [else
         (cons (list (first A) (first B)) (zip (rest A) (rest B)))]
        ))

;; p4 sorted
(define (second L)
  (first (rest L)))

(define (sorted? L)
  (cond [(or (empty? L) (empty? (rest L)))
         #t]
        [(> (first L) (second L))
         #f]
        [else
         (sorted? (rest L))]
        ))

;; p5 range
(define (range-h n i)
  (cond [(= n i)
         '()]
        [else
         (cons i (range-h n (+ i 1)))]
        ))

(define (range n)
  (range-h n 0))

(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; flatten!!!
(define (flatten L)
  (cond [(empty? L)
         '()]
        [(list? (first L))
         (append (flatten (first L)) (flatten (rest L)))]
        [else
         (cons (first L) (flatten (rest L)))]
        ))

;; ========================================================================================================
;; ====================================== RACKET PROBLEMSET ===============================================
;; ========================================================================================================
;; p1 index of
(define (index-of-acc x L acc)
  (cond [(empty? L)
         -1]
        [(equal? x (first L))
         acc]
        [else
         (index-of-acc x (rest L) (+ acc 1))]))

(define (index-of x L)
  (index-of-acc x L 0))

;; p2 my subset
(define (member? x L)
  (cond [(empty? L)
         #f]
        [(equal? x (first L))
         #t]
        [else
         (member? x (rest L))]
        ))

(define (my-subset? A B)
  (cond [(empty? A)
         #t]
        [(member? (first A) B)
         (my-subset? (rest A) B)]
        [else
         #f]
        ))

;; p3 remove duplicates
(define (remove-dups-acc L acc)
  (cond [(empty? L)
         acc]
        [(member? (first L) acc) ;; if already in acc, skip it
         (remove-dups-acc (rest L) acc)]
        [else
         (remove-dups-acc (rest L) (append acc (list (first L))))]
        ))

(define (my-remove-duplicates L)
  (remove-dups-acc L '()))

;; p4 consed out
(define (make-consed L)
  (cond [(empty? L)
         '()]
        [(list? (first L)) ;; work on the first and the rest
         (list 'cons (make-consed (first L)) (make-consed (rest L)))]
        [else ;; just work on the rest
         (list 'cons (first L) (make-consed (rest L)))]
        ))

;; p5
(define (my-map f L)
  (cond [(empty? L)
         '()]
        [else
         (cons (f (first L)) (my-map f (rest L)))]
        ))

(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
         (op (first L) (foldr op init (rest L)))]
        ))

;; ik the rest just was worried about map

;; p6
(define (my-filter p? L)
  (foldr (lambda (next acc) (cond [(p? (first L)) (cons next acc)] [else acc])) '() L))

;; p7 - still iffy 
;; its where a func takes args as two sequential calls, e.g., ((add 1) 2) => 3
(define (curry2 f)
  (lambda (x)
    (lambda (y) (f x y))))
;; e.g,.
(define add_c
  (curry2 +))

;; q8 ez
;; q9 i remember...
(define (third L)
  (first (rest (rest L))))

(define (evaluate L)
  (cond [(list? L)
         (eval (list (evaluate (first L))
                     (second L)
                     (evaluate (third L))))]
        [else
         L]
        ))

(define (eval L)
  (cond [(or (equal? 'error (first L)) (equal? 'error (third L)))
         'error]
        [(and (= 0 (third L)) (equal? '/ (second L)))
         'error]
        [(equal? '+ (second L))
         (+ (first L) (third L))]
        [(equal? '- (second L))
         (- (first L) (third L))]
        [(equal? '* (second L))
         (* (first L) (second L))]
        [(equal? '/ (second L))
         (/ (first L) (second L))]
        ))