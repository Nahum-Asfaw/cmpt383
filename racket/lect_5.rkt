#lang tiny-lisp

;; append
(define (append A B)
  (cond [(empty? A)
         B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; reverse-f
(define (reverse-f L)
  (foldr (lambda (next acc) (append acc (list next))) '() L))

;; concat
(define (concat lol)
  (cond [(empty? lol)
         '()]
        [else
         (append (first lol) (concat (rest lol)))]
        ))

;; foldr
(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
         (op (first L) 
            (foldr op init (rest L)))]))

;; length-f
(define (length-f L)
  (foldr (lambda (x) (+ x 1)) 0 L))

;; sum-f
(define (sum-f L)
  (foldr (lambda (next acc) (+ acc next)) 0 L))

;; member-f
(define (member-f x L)
  (foldr (lambda (next acc) (or (equal? next x) acc)) #f L))


;; map-f
(define (map-f f L)
  (foldr (lambda (next acc) (cons (f next) acc)) '() L))

;; filter-f 
(define (filter pred? L)
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
         (cons (first L) (insert-sorted x (rest L)))]
        ))
;; ------------------------------------------------------------------------------
;; flattening a list
(define (flatten L)
  (cond [(empty? L)
         '()]
        [(list? (first L))
         (append (flatten (first L)) (flatten (rest L)))]
        [else
         (cons (first L) (flatten (rest L)))]
        ))
;; More readable version ??? idk
(define (flatten-r L)
  (cond [(empty? L)
         '()]
        [else
         (let* [(head (first L))
                (tail (rest L))
                (flat-tail (flatten tail))]
           (cond [(list? head)
                  (append (flatten head) flat-tail)]
                 [else
                  (cons head flat-tail)]))]
        ))

;; flatten as a right fold
(define (flatten-f L)
  (foldr (lambda (next acc) (cond [(list? next) (append (flatten-f next) acc)][else (cons (first L) acc)]))
           '()
           L))

;; This is the first time I've seen a function with a right fold call itself in the lambda. When
;; written out like this, it makes sense, but cmon

;; Quicksort
;; quicksort is another algorithm that works by selecting a pivot element, partitioning the list into
;; two sub-lists around that pivot, and recursively sorting the two sub-lists.
;; Here is an implementation of quicksort that chooses the first element of the list as the pivot.
(define (quicksort L)
  (cond [(<= (length-f L) 1)
         L]
        [else
         (let* [(pivot
                 (first L))
                (smalls
                 (filter (lambda (n) (< n pivot))
                                (rest L)))
                (bigs
                 (filter (lambda (n) (>= n pivot))
                              (rest L)))
                ]
           (concat (list (quicksort smalls)
                         (list pivot)
                         (quicksort bigs))))]))

;; doesn't seem to work
;; ---------------------------------------------------------------------------------------------------
;; Deep functions
;; a deep function is a function that operate on a list, and goes into nested sub-lists.
;; For example, (deep-sum L) returns the sum of all the numbers in the liset, includign the numbers
;; in the nested lists. For example, (deep-sum '((1 ((2)) 3) (4 5) 6)) evaluates to 21
;; An idea for implementing deep-sum is to flatten the list and use sum. p simple
(define (deep-sum L)
  (sum-f (flatten L)))
;; same idea for member
(define (deep-member x L)
  (member-f x (flatten L)))

;; doesn't work for everything, e.g., deep-map:
(define (deep-map f L)
  (foldr (lambda (next acc)
           (cons (cond [(list? next) (deep-map f next)]
                       [else
                        (f next)])
                 acc))
         '()
         L))
;; --------------------------------------------------------------------------------------------
;; Closures...
;; a closure combines two things: a function, and an enviornment of variables and their values. The
;; function can use variables from this enviornment. For example, this is a function, but not a closure:
(define (f n)
  (+ n 1))
;; now consider this one:
(define (make-adder n)
  (lambda (x) (+ n x)) ;; n is outside the lambda
  )

(define g (make-adder 1)) ; g is a closure
;; g is a closure because it has both a function and a binding for the variable n. By itself, the function
;; (lambda (x) (+ n x)) can't be evaluated because variable n is free. But in g, n is bound to the value 1.
;; the function plus this binding of n is a closure.
;; conceptually, you can think of a closure as being let over lambda:
(define g1
  (let ([n
         1])
    (lambda (x) (+ n x)))
  )
;; g1 is not just a function, but a function along with variable bindings that it can use.
;; Free variables are variables that appear in a function but aren't declared in the function. For example,
;; n is free in (lambda (x) (+ n x)). Any programming language that lets you define functions inside of
;; functions must decide how to handle free variables. Closures are a common solution to this problem.
;; Another is to simply disallow returning functions with free variables, but this reduces the flexibility
;; of returning functions.
;; -----------------------------------------------------------------------------------------------------
;; composing functions
;; recall how function composition works in mathemetics. Suppose you have these two functions:
;; f(x) = x**2
;; g(x) = (2*x) + 1
;; the composition of f and g is:
;; f(g(x)) = g(x)**2
;;         = ((2*x) + 1)**2
;;         = (4*x)**2 + (4*x) + 1

;; ∘ is the function operator:
;; (f∘g)(x) = (4*x)**2 + (4*x) + 1

;; In code, we can compose functions directly by calling them:
(define (comp f g)
  (lambda (x) (f (g x))))

;; The idea is that (comp f g) returns a function that first applies g to its inputs, then applies f to the
;; results of that, i.e., it does g then f.
;; This lets us define h from above without explicitly using x:
(define h (comp f g))

;; Here's a function that returns the second element of a list:
(define my-second (comp first rest))

;; we call (my-second L), but the L param doesn't appear in the definition of my-second: it is implicit!
;; L IS THE (x) IN THE LAMBDA EXPRESSION: lambda (x) (f (g x))). THIS IS HOW PARAMS ARE RECORDED FOR COMPS
;; the twice function takes a function f as input and returns f composed with itself, i.e., f∘f:
(define (twice f) (comp f f))

;; for instance:
(define garnish 
    (twice (lambda (x) (cons 'cheese x)))
)

;; composing multiple functions
;; racket's built-in compose function lets you copose 2 or more functions, but it is not part of tiny lisp.
;; So lets implement our own version called (compose-all f1 f2 .. fn) that returns the composition of f1 to
;; fn, i.e., (f1 (f2 ... (fn x))).
;; Recall that right fold is (foldr op init L). What would be init for composition? in other words, what
;; should init be in (cop f (comp g (comp h init)))?
;; The answer is the identity function, i.e., the function that returns whatever you pass it.
;; We could write it as I(x) = x, and so for example, f∘I = f.
;; Now we can write compose-all as a right fold:
(define (compose-all fns)
  (foldr comp (lambda (x) x) ;; identity function
         fns))

;; here's an example of hwo this works:
(define (f1 x) (append x (list 'f1)))
(define (g2 x) (append x (list 'g2)))
(define (h3 x) (append x (list 'h3)))

(define seq1 (compose-all (list f1 g2 h3)))
;; dosen't work...
;; > (seq1 '(test))
;; (test h g f)
;; This shows that the functions are applied in reverse order, which most people find counter-intuitve.
;; So lets write a variation of compse-all that pplies the functions in the order they are given:
;; (define (pipeline fns) (compose-all (reverse fns)))
;; This lets us write the functions in the order they're applied:
(define (pipeline fns)
  (compose-all (reverse-f fns)))

;; This lets us write the functions in the order they're appled:
(define seq2 (pipeline (list f1 g2 h3)))

;; > (seq2 '(test)
;; (test f g h)
;; -----------------------------------------------------------------------------------------------
;; Curried functions
;; The idea of currying is to treat a function that takes more than 1 input as a series of functions that
;; take 1 input each.
;; Here are two different ways to write the addition function:
(define add_a (lambda (x y) (+ x y))) ;; uncurried
(define add_b (lambda (x) (lambda (y) (+ x y)))) ;; currued

;; add_a takes two inputs, and immediately returns an answer. add_b takes only one input, and returns a
;; function. This returned function takes the second input and returns the sum of the two inputs.
;; The nice thinkg about add_b is that if we give it only a single input n, we get a useful function:
(define add5 (add_b 5))

;; In tiny lisp, most functions are not written in a curred style. We can write a function that converts
;; a non-curried function into a curried one:

;; assumes f is a 2-param
;; returns a curried version of f
(define (curry2 f)
  (lambda (x) (lambda (y) (f x y))))

;; For example,
(define add3 ((curry2 +) 5))

;; + is a pre-defined 2-arg function, so (curry2 +) is equivalent to this:
;; (lambda (x) (lambda (y) (+ x y))) ;; curried version of +

;; Thus ((curry2 +) 5) is this:
;; Here's another example. Recall that (filter pred? L) returns a new list containing just the elements
;; of L that satisfy the predicate pred?.
;; We could write a curried version likes this:
(define keep-odds ((curry2 filter) odd?))

;; > (keep-odds '(1 2 3 4 5))
;; (1 3 5)

;; any function that takes two inputs can be curred. For example,
;; curried versions of some standard functions
(define c_+ (curry2 +))
(define c_cons (curry2 cons))
(define c_filter (curry2 filter))

;; some definitions that use curried functions
(define inc (c_+ 1))
(define fil (c_filter odd?))
(define add-cherry (c_cons 'cherry))

;; Finally, the uncurry2 functon takes a 2-arg curred function as input and returns a non-curried version
;; of it:
;; converts a 2-arg curried func to a non-curried func
(define (uncurry2 f)
  (lambda (x y)
    ((f x) y)))

;; since functions are non-curried by default, uncurrying isn't common in tiny lisp.
;; -----------------------------------------------------------------------------------------------------
;; Combinators
;; Lets take a look at some simple higher-order functions called combinators. They are pure funtions, i.e.,
;; functions that don't have any side-effects (such as changing global variables, printing to the screen,
;; opening a file, etc.), and whose result is always the same for the same input.
;; They can be combined to build many other functoins, and are of interest in theoretical computer science.

;; The I combinator.
;; (I x) is the identity function, and it returns whatever you pass it:
(define (I x) x)

;; > (I 4)
;; 4
;; > (I '(a b c)
;; '(a b c)
;; > (I I)
;; #<procedure:I>

;; The M combinator
;; The function (M x) takes a function x as input, and calls x on itself.
(define (M x) (x x))

;; > (M list) ;; (list list)
;; '(#<procedure:list>)
;; > (M symbol?) ;; (symbol? symbol?)
;; #f
;; > (M I) ;; (I I)
;; #<procedure: I>
;; > (M 4) ;; (4 4)
;; . . application: not a procedure;
;; expected a procedure that can be applied to args

;; The expression (M M) is interesting: it is an infinte loop that never returns a value. When you call
;; (M, M), the argument M replaces x in the body of function M, i.e., (x, x) becomes (M M). This evaluates
;; (M, M), and the same thing happens again and again forever.

;; We could also write M as a lambda function:
;; (lambda (x) (x x))
;; Then, (M M) is the same as:
;; ((lambda (x) (x x)) (lambda (x) (x x)))

;; The K combinator
;; The function (K x) returns a function that takes a single input y, and for any value of y, returns x.
;; In other words, it returns a constant function that always returns x:
(define (K x) (lambda (y) x))

;; > ((K 'pizza) 'ignored)
;; 'pizza
;; > (map (K 5) '(a b c d))

;; The S combinator
;; Function S3 takes 3 inputs:
(define (S3 x y z)
  ((x z) (y z)))

;; This is pretty weird! x and y are functions, and z is an arg to both. x must also return a function that
;; can be appleid to the output of y. Here is an example of calling it:
;; helper functions
(define (make-add a) (lambda (n) (+ n a)))
(define (times2 n) (* 2 n))

;; > (S3 make-add time2 3)
;; 9

;; The call to S3 is evaluated like this:
;; (S3 make-add times2 3)
;; ((make-add 3) (times2 3))
;; ((make-add 3) 6)
;; ((lambda (n) (+ n 3)) 6)
;; (+ 6 3)
;; 9

;; Intuitively, S3 can be thought of as a generalization of a function composition.
;; (S3 x y z) composes x and y - but it first calls x on z and y on z (and composes the results).
;; S is a curried version of S3. You can pass 0, 1, 2, or 3 arguments to S (you must always pass exactly
;; 3 arguments to S3):
;; (define S (curry S3)) ;; curry is a built-in function, not in tiny-lisp
;; This lets us pass 0, 1, 2, or 3 args to S, which is useful for combining combinators.

;; I in terms of S and K
;; Interestingly, the identity function I can be defined in terms of S and K like this:
;; (define (I a) ((S K K) a))

;; To see why this is true, let's evaluate ((S K K) 'a). Since S is curried, (S K K) evals to a func
;; that takes one arg, which in this example is 'a. Thus, ((S K K) 'a) evals to ((K 'a) (K 'a)).
;; (K 'a) returns a function that always returns 'a so ((K 'a) (K 'a)) evaluates to 'a. And so ((S K K) 'a)
;; evaluates to 'a, which means (S K K) is the identity function.

;; Completeness of S and K
;; Why bother with little functions like S and K? They don't seem very useful.
;; Suprisingly, functions S and K can be combined to define any other pure function. You could think of
;; S and K like a low-level assembly language for pure functions, or as the atoms of computation.
;; We won't cover the proof here, but check out
;; https://en.wikipedia.org/wiki/Combinatory_logic#Completeness_of_the_S-K_basis
;; if you're curious.
;; -------------------------------------------------------------------------------------------------------
;; Case Study: Symbolic Programming
;; One of the original uses of Lisp was symbolic programming, e.g., doing algebra using variables
;; instead of numbers. Even today, it can be useful tool for such problems.

;; Propositional Logic
;; Lets write some functions that process a language of literal boolean propositional expressions like
;; (t and (not f)) and ((f or f) and ((not t) and f)).
;; The symbols t and f stand for true and false. Importantly, they are not the built-in boolean values
;; (#t and #f) since this is our owun little language different from racket.

;; Checking Valid expressions
;; The first thing we will write is a function that checks if an expression if valid propositional
;; logic for our expression. We consider the following to be valid expressions:
;; - t
;; - f
;; - (not e) where e is a valid expression
;; - (e1 and e2) where e1 and e2 are valid expressions
;; - (e1 or e2) where e1 and e2 are valid expressions
;; - (e1 implies e2) where e1 and e2 are valid expressions
;; - (e1 iff e2) where e1 and e2 are valid expressions

;; We will write two different solutions: the first using many small helper functions, and the
;; second using match.

;; Recognizing propositional expressions
;; The first thing we will do is implement recognizer functions that check if an expression is a valid
;; propositional logic expression:

;; recognizing literals t and f
(define (is-true? e) (equal? e 't))
(define (is-false? e) (equal? e 'f))

;; general helper functions
(define (length L) (cond [(empty? L)
                          0]
                         [else
                          (+ 1 (length (rest L)))]
                         ))

(define (second L)
  (first (rest L)))

;; returns true if L is a list of length n
(define (nL? n L)
  (and (list? L) ;; and means both (list? L) and (= n (length L)) need to be true.
                 ;; will end at (list? L) if it is false.
       (= n (length L))))

;; recognizing a not expression
;; (not expr)
(define (is-not? e)
  (and (nL? 2 e) ;; List must be of length 2
       (equal? 'not (first e)))) ;; and the first element of the list must be 'equal

;; recognizing binary expressions of the form (p op q)
(define (is-bin-op? e op)
  (and (nL? 3 e) ;; makes sense
       (equal? op (second e)))) ;; ???
