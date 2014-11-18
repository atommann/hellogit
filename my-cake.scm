;; ---begin my-cake.scm---
(define-module (my-cake) ; define a 'cake' module based on racket/base
  #:use-module (ice-9 format) ; the pre-requisition of current module
  #:export (print-cake)) ; function exported by the module

  (define (show fmt n ch) ; internal function
    (format #t fmt (make-string n ch))
    (newline))

  (define (print-cake n)
    (show "   ~a   " n #\.)
    (show " .-~a-. " n #\|)
    (show " | ~a | " n #\space)
    (show "---~a---" n #\-))

;; ---end my-cake.scm---
