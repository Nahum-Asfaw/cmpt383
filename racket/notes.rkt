#lang tiny-lisp
;; Functions to Know
;; The following functions are all useful for working with lists, and are good practice
;; for writing recursive functions in LISP.

;; Length of a list:
;; (length L) returns the number of elements in the list L. The recursive idea is:
;; - return 0 if the list is empty
;; - otherwise, return 1 plus the length of the rest of the list

(define (length L)
  (cond [(empty? L) 0]
        [else
         (+ 1
            (length (rest L)))]
        ))

;; Sum and Product of a list
;; The sum and product of a list are conceptually similar to the length of a list. To
;; calculate the sum of a list, the recursive idea is:
;; - return 0 if the list is empty
;; - otherwise, return the first element plus the sum of the rest of the list

(define (sum L)
  (cond [(empty? L) 0]
        [else (+ (first L)
                 (sum (rest L)))]
        ))

(define (product L)
  (cond [(empty? L) 1]
        [else (* (first L)
                 (product (rest L)))]
        ))

;; Member of a list
;; (member? x L) returns #t if x is an element in L, #f otherwise. The recursive idea is:
;; - return #f if the list is empty
;; - else, return #t if its first element is x
;;         - otherwise, return the result of (member? x (rest of L))

(define (member? x L)
  (cond [(empty? L)
         #f]
        [(equal? x (first L))
         #t]
        [else (member? x (rest L))]
        ))

;; Count Occurrenes
;; (count x L) returns the number of occurrences of x in the list L. The recursive idea is:
;; - return 0 if the list is empty
;; - else, if x is the first element of L, return 1 plus the count of x in the rest of L
;; - otherwise, return the count of x in the rest of L

(define (last L)
  (cond [(empty? L)
         (error "last: empty list")]
        [(empty? (rest L))
         (first L)]
        [else
         (last (rest L))]
        ))

;; nth Element
;; (nth n L) returns the item at index location n in the list L. Let's make the indexing
;; zero-based, so the first element is at index 0, the second element is at index 1, etc.
;; The recursive implementation idea is:
;; - return an error if the list is empty, or if n is negative
;; - else, if n is 0, return the first element of the list
;; - otherwise, return the item at index n-1 in the rest of the list

(define (nth n L)
  (cond [(empty? L)
        (error "nth: index out of range")]
        [(< n 0)
         (error "nth: negative index")]
        [(= n 0)
         (first L)]
        [else
         (nth (- n 1) (rest L))]
        ))

;; Remove all occurences of an element from a list
;; (remove x L) returns a new list with all occurrences of x removed from list L. The
;; recursive idea is:
;; - return an emtpy list if the list is empty
;; - else, if the first element is x, return the result of (remove x (rest L))
;; - otherwise, return the first element followed by the result of (remove x (rest L))

(define (remove_all x L)
  (cond [(empty? L)
         '()]
        [(equal? x (first L))
         (remove_all x (rest L))]
        [else
         (cons (first L) (remove_all x (rest L)))]
        ))

;; Append two lists
;; (append A B) returns a new list that is the concatenation of the lists A and B. The
;; recursive idea is:
;; - return B if A is empty
;; - Otherwise, return the first element of A followed by the result of (append (rest A) B)
(define (append A B)
  (cond [(empty? A)
        B]
        [else
         (cons (first A) (append (rest A) B))]
        ))

;; Append all lists in a list
;; (concat list-of-lists) returns a new list that is the concatenation of all lists in
;; list-of-lists. The recursive idea is:
;; - return an empty list if list-of-lists is empty
;; - otherwise, append the first list of list-of-lists to the result of
;; - (concat (rest list-of-lists))

(define (concat list-of-lists)
  (cond [(empty? list-of-lists)
         '()]
        [else
         (append (first list-of-lists)
                 (concat (rest list-of-lists)))]
        ))

;; Reserve a list
;; (reverse L) returns a new list that is the reverse of the list L. The recursive idea is:
;; - return an empty list if L is empty
;; - otherwise, return the result of (append (reverse (rest L)) list (first L)))
(define (reverse L)
  (cond [(empty? L)
         '()]
        [else
         (append (reverse (rest L))
                 (list (first L)))]
        ))

;; Unfortunately, this version of reverse is a quadratic-time operation. Tracing it helps show why:
;; (reverse '(1 2 3)
;; = (append (reverse '(2 3)) '(1))
;; = (append (append (reverse '(3)) '(2)) '(1))
;; = (append (append (append '() '(3)) '(2)) '(1))
;; = (append (append '(3) '(2)) '(1))
;; = (append '(3 2) '(1))
;; = (3 2 1)

;; Each time the recursive call to reverse is made, it calls append, and because append is linear-time,
;; the running time of reverse adds up to being quadratic.

;; Reverse a list with an accumulator
;; (reverse-acc L) returns a new list that is the reverse of the list L. It does it using an accumulator,
;; which lets it run in linear time. The idea of an accumulator is to keep track of the result as we go
;; so that we don't have to call append repeatedly.
(define (reverse-acc L acc)
  (cond [(empty? L)
         acc]
        [else
         (reverse-acc (rest L)
                      (cons (first L) acc))]
        ))

(define (reverse2 L)
  (reverse-acc L '()))

;; The first thing to notice is that there are two functions: reverse2 is the one the user should usually
;; call, and reverse-acc is the helper function that does the actual work. reverse-acc takes two args:
;; the list to reverse, and an accumulator. The accumulator is initally empty, and is usd to build the
;; result. There is no call to append in reverse-acc, and all other functions are constant time, so
;; the running time ils linear.
;; Using an accumulator is a common technique for speeding up recursive functions. It comes at the cost
;; of adding a second param, and thus a helper function is usually used.

;; Length and sum with an accumulator.
;; Recall the length function from line 11. We can rewrite it using an accumulator:
(define (length-acc L acc)
  (cond [(empty? L)
         acc]
        [else
         (length-acc (rest L)
                     (+ acc 1))]
        ))

(define (length2 L)
  (length-acc L 0))

;; Here, acc stores the running count of the number of elements in the list:
;; (length2 '(a b c))
;; = (length-acc '(a b c) 0)
;; = (length-acc '(b c) 1)
;; ...
;; = (length-acc '() 3)
;; = 3

;; Compare this to the trace of the original length function:
;; (length '(a b c))
;; = (+ 1 (length '(b c)))
;; = (+ 1 (+ 1 (length '(c))))
;; = (+ 1 (+ 1 (+ 1 (length '()))))
;; = (+ 1 (+ 1 (+ 1 0)))
;; = 3

;; length and length2 both have about the same running time, but length2 is more space-efficient
;; because it doesn't need to build up the list (+ 1 (+ 1 (...))).
;; We can also use an accumulator to speed up the sum function:
(define (sum-acc L acc)
  (cond [(empty? L)
         acc]
        [else
         (sum-acc (rest L)
                  (+ acc (first L)))]
        ))

(define (sum2 L)
  (sum-acc L 0))

;; Here's a trace:
;; = (sum-acc '(4 5 6) 0)
;; = (sum-acc '(5 6) 4)
;; = ... = (sum-acc '() 15)
;; = 15

;; Compare this to the sum function on line 24: Like length, sum uses more memory than sum2 because
;; it builds up the list (+4 (+ 5 (+ 6 (...)))

;; Map a list
;; (map f L) returns a new list that is the result of applying the function f to each element of the
;; list L. For example, (map square '(1 2 3)) returns (1 4 9), and (map (lambda (x) (+ x 1)) '(1 2 3))
;; returns (2 3 4)
;; In the call (map fn L), fn is a function that takes one input, and L is a list of 0 or more elements
;; that fn can be applied to. fn is often written as a lambda expression.

;; The recursive idea for implementing map is:
;; - return an empty list if L is empty
;; - Otherwise, return the result of applying f to the first element of L followed by the result of
;; (map f (rest L))
(define (map fn L)
  (cond [(empty? L)
        '()]
        [else
         (cons (fn (first L))
               (map fn (rest L)))]
        ))

;; Filter a list
;; The function (filter pred? L) returns a new list that contains just the elements of L that satisfy the
;; predicate pred?. For example, (filer even? '(1 2 3 4 5)) returns just (2 4), and
;; (filter (lambda (x) (> x 3)) '(1 2 3 4 5)) returns (4 5)
;; pred? is a function that takes one input, and returns a boolean value, i.e., #t or #f. L is a list of
;; 0 or more elements that pred? can be applied to. As with map, pred? is often written as a lambda
;; expression.
;; The recursive idea for implementing filter is:
;; - return an empty list if L is empty
;; - otherwise, if the first element of L satisfies pred?, return a new list with the first element of L
;; followed by the result of (filter pred? (rest L))
;; - otherwise, return the result of (filter pred? (rest L))
(define (filter pred? L)
  (cond [(empty? L)
         '()]
        [(pred? (first L))
         (cons (first L)
               (filter pred? (rest L)))]
        [else
         (filter pred? (rest L))]
        ))

;; pred? is called exactly once for each elemnt of L, and so the running time is proportional to the
;; length of L. If pred? is a constant-time operation, then filter is a linear-time operation. If
;; pred? is a linear-time opteration, then filter is a quadratic-time operation.
;; In practice, filter is quite useful and goes together well with map. E.g.,
;; (map (lambda (x) (* x x))
;;    (filter even? '(1 2 3 4 5))

;; all
;; (all pred? L) returns #t if all the elements of L satisfy the predicate. Or, a little more precisely,
;; (all pred? L) returns #t just when there are no elements in L that make pred? return #f.
;; pred? is a boolean predication function that takes one input and returns #t or #f, while L is a list
;; of 0 or more elemetns tha pred? can be applied to.
;; For example, (all even? '(2 4 6)) returns #t, and (all symbol? '(two 4 five)) returns #f.

;; The recursive idea for implementing all is:
;; - return #t if L is empty ??????????
;; - otherwise, if the first element of L satisfies pred?, return the result of (all, pred? (rest L))
;; - otherwise, return #f
(define (all pred? L)
  (cond [(empty? L)
         #t]
        [(pred? (first L))
         (all pred? (rest L))]
        [else
         #f]
        ))
;; Ther is another way to implement all using filter. The idea is to filter the elements that don't
;; satisfy pred?. If that filtered list is length 0, then all the elements of L satisfy pred?. Otherwise,
;; some element of L does not satisfy pred?, and so all returns #f:
(define (all2 pred? L)
  (empty? (filter (lambda (x) (not (pred? x)))
                  L)))

;; Unfortunately, this version is slower than the recursive version. The recursive version ends as soon
;; as pred? returns #f: there is no reason to keep checking once we know that the result is #f.

;; Folding a list
;; Folding a list is a pweful technique that we'll introduce through an example. Consider the list
;; '(a b c d). We can write the list as a series of nested calls to cons:
;; '(a b c d)
;; = (cons 'a (cons 'b (cons 'c (cons 'd '())))))
;; We'll call the expression (cons 'a (cons 'b (cons 'c (cons 'd '()))))) the consed-out form of the list
;; '(a b c d)
;; Notice a few things:
;; - cons is a binary function, i.e., it takes two inputs and returns one output
;; - the second param for the last cons is the empty list '()

;; Now imagine the generalization of the cons-ed out form to work with any binary function (on values
;; that make sense for it). For instance, imagine replacing cons with +:
;; (+ 1 (+ 2 (...)))
;; Or replace cons with *:
;; (* 1 (* 2 (...)))
;; Now lets generalize this. Suppose you have a list of elements '(a b c d), and a binary operator op that
;; works those list values, and also have the final init for the last call to op. Then we can calculate
;; the folded form of the list like this:
;; (op a (op b (op c (op d init))))
;; This is called a fold, or more specifically, a right fold because the brackets are nested to the right.
;; In lisp, it is usually called foldr, and would be called like this:
;; (foldr op init '(a b c d))
;; = (op a (op b (op c (op d init))))

;; To write (foldr op init L), we can use this recursive idea:
;; - return init if L is empty
;; - otherwise, apply op to the first element of L and the result of (foldr op init (rest L))
(define (foldr op init L)
  (cond [(empty? L)
         init]
        [else
         (op (first L)
             (foldr op init (rest L)))]
        ))

;; Sum as a right fold
;; we can implement (sum l) as a right fold:
(define (sum-f L)
  (foldr + 0 L))

;; Length as a right fold
;; the length function can be written like this:
(define (length-f L)
  (foldr (lambda (next acc) (+ acc 1))
         0
         L))

;; The key idea is the folding function (lambda (next acc) (+ acc 1)). This is a binary function that
;; takes two inputs: the next element of the list, and the accumulated value of the previous calls to
;; the folding function.
;; Calling (foldr op 0 '(a b c)) gives this:
;; (foldr op 0 '(a b c))
;; = (op a (op b (op c 0)))
;; op is (lambda (next acc) (+ acc 1)), so when we do one step of evaluation we get:
;; - (foldr op 0 '(a b c))
;; = (op a (op b (op c 0))))
;; - (op a (op b (+ 0 1)))

;; The c disappears because the body of op adds 1 to the accumulated value. Continuing the process, the
;; calls to op are evaluated in the usual way:
;; ... idk

;; Member has a right fold
;; The (member x L) function can be written like this:
(define (member-f x L)
  (foldr (lambda (next acc) (or (equal? next x) acc))
        #f
        L))

;; for example, (member? 3 '(1 2 3 4)) evaluates to:
;; (or (equal? 1 3)
;;     (or (equal? 2 3)
;;         (or (equal? 3 3) ;; a match!
;;             (or (equal? 4 3) #f))))

;; Append as a right fold
;; The (append A B) function can be written as this simple right fold:
(define (append-f A B)
  (foldr cons B A))

;; Map and filter as right folds
;; The (map f L) function can be written as a right fold:
(define (map-f fn L)
  (foldr (lambda (next acc) (cons (fn next) acc))
         '()
         L))

;; To understand this, look at the folding function (lambda (next acc) (cons (fn next) acc)). Intuitevly,
;; it applies fn to each next element of the list, and then pushes the result onto the front of the
;; accumulated values.
;; (filter pred? L) can be written as a right fold:
(define (filter-f pred? L)
  (foldr (lambda (next acc)
           (cond [(pred? next)
                  (cons next acc)]
                 [else
                  acc]))
         '()
         L))

;; The folding function for filter is a little more complex. It checks if the next element satisfies
;; pred?. If it does, it pushes it onto the frion tof the accumulated values. If it does not, it skips
;; the element and keeps the accumulated values as is.

;; Flatten a list
;; (flatten L) returns a new list with all internal lists removed, but the non-list elements kept as they
;; are in the order they apear in the original list.
;; For example:
;; - (flatten '((a) ((c d (e f)) g) h)) => '(a c d e f g h)
;; - (flatten '(define (x y) (+ x y))) => (define x y + x y)

;; A recursive idea for implementing flatten is:
;; - return an empty list if L is empty
;; - if the first element of L is a list, return the result of flattening that first element, and append
;; it to the rest of the list
;; - otherwise, make a new list with the first element of L followed by the flattened rest of the list
(define (flatten L)
  (cond [(empty? L)
         '()]
        [(list? (first L))
         (append (flatten (first L))
                 (flatten (rest L)))]
        [else
         (cons (first L)
               (flatten (rest L)))]
        ))

;; Note that the implementation repeats (first L) and (rest L) a copule of times. This does not slow down
;; the function (since the repeats are diffent cond clauses), but it does arguably make the code less
;; readable.

;; So here is an alternative implementation that uses let* to avoid the repitition:
(define (flatten2 L)
  (cond [(empty? L)
         '()]
        [else
         (let* [(head (first L))
                (tail (rest L))
                (flat-tail (flatten2 tail))]
           (cond [(list? head)
                  (append (flatten2 head) flat-tail)]
                 [else
                  (cons head flat-tail)]))]
        ))

;; It might be easier for programmers to see the structure of the code here.
;; Another idea for implementiong flatten is to use a right fold. The basic idea is:
(define (flatten-f L)
  (foldr (lambda (next acc)
           (cond [(list? next)
                  (append (flatten-f next) acc)]
                 [else
                  (cons next acc)]))
         '()
         L
         ))

;; deep functions
;; A deep function is a function that operates on a list, and can contain nested lists.
;; For example, (deep-sum) returns the sum of all numbers in the list, including the numbers in the
;; nested lists. For example, (deep=sum '((1 ((2)) 3) (4 5) 6)) evaluates to 21.
;; An idea for implementing deep-sum is to flatten the list and then use a regular shallow sum function
;; we've already defined:
(define (deep-sum L)
  (sum (flatten L)))

;; This works because (flatten L) returns a list of all the numbers in the list, including the numbers
;; in the nested lists. Then foldr + 0 (flatten L)) returns the sum of all the numbers in the list.
;; Another example is (deep-member? x L), which returns #t if x is found in the list, including the
;; nested lists. For example, (deep-member? 2 '((1 ((2)) 3) (4 5) 6)) evaluates to #t
;; Again, it can be implemented using flatten and the regular shallow member? function:
(define (deep-member? x L)
  (member? x (flatten L)))

;; Not all deep functions can be implemented using flatten. For example, (deep-map fn L) returns a new
;; list with fn applied to each element of the list, including the elements in the nested lists.
;; Importantly, deep-map preserves nested structure of the list.
;; For example, (deep-map square '((1 2) (3 4) 5)) evals to '((1 4) (9 16) 25).
;; An idea for implementing deep-map is to use a right fold. The idea is that each next new item in the \
;; list is either a list or a non-list. If it is a list, it should be deep-mapped and put onto the front
;; of the accumulated value. If it is a non-list, it should have fn applied to it and put onto the front
;; of the accumulated value.

(define (deep-map fn L)
  (foldr (lambda (next acc)
           (cons (cond [(list? next)
                        (deep-map fn next)]
                       [else
                        (fn next)])
                 acc))
         '()
         L))

;; Insertion sort
;; Recall that insertion sort is an elementary sorting algo that sorts a list of numbers by scanning
;; through the list and inserting each number in the correct position in a new list.
;; insertion sort can be implemnted using w right fold. Each new number in the list is inserted into
;; the correct position of the accumulated list (which is in sorted order) using a helper function
;; inserted-sorted:
(define (insertion-sort L)
  (foldr insert-sorted '() L))

;; For this to work we need to write (inserted-sorted x L), where L is in soted order. It returns a new
;; list with x inserted into the correct position, e.g.:
;; (insert-sorted 3 '(1 2 3 4 5))
;; '(1 2 3 4 5)

;; A recursive idea for implementing insert-sorted is:
;; - return a list with x if L is empty
;; - if x is less than or equal to the first element of L, insert x at the front of L
;; - otherwise, insert x at the front of the rest of L and cons the first element of L back onto the
;; result.

;; Here is an implementation of insert-sorted:
(define (insert-sorted x L)
  (cond [(empty? L)
         (list x)]
        [(<= x (first L))
         (cons x L)]
        [else
         (cons (first L)
               (insert-sorted x (rest L)))]
        ))

;; quicksort with filter
;; Quicksort is another fundamental sorting algorithm that works by selecting a pivot element,
;; partitioning the list into two sublists around the pivot, recursively sorting the two sublists,
;; Here is an implementation of quicksort that chooses the first element of the list as the pivot:
(define (quicksort L)
  (cond [(<= (length L) 1)
         L]
        [else
         (let* [(pivot (first L))
                (smalls (filter (lambda (n) (< n pivot))
                                (rest L)))
                (bigs (filter (lambda (n) (>= n pivot))
                              (rest L)))
                ]
           (concat (list (quicksort smalls)
                         (list pivot)
                         (quicksort bigs))))]
        ))