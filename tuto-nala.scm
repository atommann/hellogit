;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 我不能很好理解 Record Type 那个例子

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(filter even? '(1 2 3 4))    ; => '(2 4)
;; filter 是高阶函数吗？

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-modules (srfi srfi-43))
(vector-append #(1 2 3) #(4 5 6)) ; => #(1 2 3 4 5 6)
;; 没问题

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define m (make-hash-table))
;; make-hash-table 没有参数？

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(hash-remove! m 'a) ; => ((b . 2) (c . 3))
;; 结果为什么不是写成 ((b  2) (c  3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; case-lambda 很有意思，居然可以这样干！

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define* (hello4 #:key (name "World"))
  (string-append "Hello " name))
;; 这个例子里，我能加自己的参数吗？比如
(hello4 "world")
;; 好像不行
;; 下面这个方法可以
;; (hello4 #:name "universe")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Functions can pack extra arguments up in a list
(define (count-args . args)
  (format #t "You passed ~a args: ~a" (length args) args))
(count-args 1 2 3) ; => "You passed 3 args: (1 2 3)"
;; 这种 . 语法把参数打包成一个 list?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ... or with the unsugared `lambda' form:
(define count-args2
  (lambda args
    (format #t "You passed ~a args: ~a" (length args) args)))
;; lambda 后面的 args 不在括号里？


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define* (hello #:key (name "World") (greeting "Hello") . args)
  (format #t "~a ~a, ~a extra args~%" greeting name (length args)))
;; 在定义函数时 #:key 的作用是什么？

(hello 1 2 3 #:greeting "Hi" #:name "Finn" 4 5 6) ; => "Hi Finn, 10 extra args"
;; 到处都可以放参数？没有顺序？

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 11
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eq? eqv? equal?
;; 这么多，到底用哪一个！写 scheme 时，手边得准备一个 eq refcard!　(墙上贴一张参考卡)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 12
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Another EXECISE, what's the proper 'equal-pred' for functions?
(what-to-use? (lambda (x) (1+ x)) (lambda (x) (1+ x)))

;; 因为 lambda 表达式本身是个 list，因此 list 自动补齐告诉我 list= 可以
(list= (lambda (x) (1+ x)) (lambda (x) (1+ x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if #t               ; test expression
    "this is true"   ; then expression
    "this is false") ; else expression
; => "this is true"
;; 我觉得用 "this is true" 不恰当，应该是 if true, this will be evaluated.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `cond' chains a series of tests to select a result
(cond [(> 2 2) (error "wrong!")]
      [(< 2 2) (error "wrong again!")]
      [else 'ok]) ; => 'ok
;; 咦，可以用方括号 []?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; For Guile users:
(use-modules (ice-9 match)) ; use match module
(define (fizzbuzz? n)
  (match (list (remainder n 3) (remainder n 5))
    ((0 0) 'fizzbuzz)
    ((0 _) 'fizz)
    ((_ 0) 'buzz)
    (else #f)))
;; _ 符号是什么意思？

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Similarly, with a named let
(let lp ((i 0))
  (when (< i 10)
    (format #t "i=~a\n" i)
    (lp (1+ i)))) ; => i=0, i=1, ...

;; named let?
;; let 加本地变量我用过，let 定义函数没用过。


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 17
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (range from to) (map (lambda (x) (+ from x)) (iota (- to from))))
;; EXECISE: you may find this 'range' implementation is not so good,
;;          please optimize it if you can.
(range 5 10) ; => (5 6 7 8 9)

;; 没有想到

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 18
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; how to do iteration?
(for-each display '(1 2 3 4 5))

;; for-each 也是高阶函数

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 19
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define vector-for-each (@ (rnrs) vector-for-each))
;; export vector-for-each from rnrs only
(vector-for-each display #(v e c t o r))
;; => vector

;; 这种函数定义写法很奇怪。

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 20
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; More Iterations
(do ((i 10 (1+ i)) (j '(x y z) (cdr j))) 
    ((null? j)) ; if j is '(), just end the loop
  (format #t "~a:~a " i (car j)))
; => 0:x 1:y 2:z

;; 我得到的结果是 10:x 11:y 12:z
;; 研究一下 do 循环

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 21
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; To catch exceptions, use the 'catch' form
(catch 'my-error 
  (lambda () (throw 'my-error))
  (lambda e (display "oh~my error!\n")))
; => oh~my error!

;; 异常，没看懂。

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 22
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use fluid for explicitly mutable values
(define n* (make-fluid 5))
(fluid-set! n* (1+ (fluid-ref n*)))
(fluid-ref n*) ; => 6

;; 这个有什么用途？

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 23
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Create an empty mutable hash table and manipulate it
(define m3 (make-hash-table))
(hash-set! m3 'a 1)
(hash-set! m3 'b 2)
(hash-set! m3 'c 3)
(hash-ref m3 'a)   ; => 1
(hash-ref m3 'd 0) ; => 0
(hash-remove! m3 'a)

;; 这个例子和前面的 hash 例子重复了。


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 24
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; scheme@(guile-user)> (print-cake 33)
;;    .................................   
;;  .-|||||||||||||||||||||||||||||||||-. 
;;  |                                   | 
;; ---------------------------------------

;; This is interesting!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question 25
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(let ((i 0))
  (while (< i  10)
    (displayln i)
    (set! i (1+ i))))

;; 我的 guile 没有 displayln

