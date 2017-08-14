#lang racket

;; Exercise 1.42: Let f and g be two one-argument functions. The composition f
;; after g is defined to be the function $x \mapsto f(g(x))$. Define a procedure
;; compose that implements composition. For example, if inc is a procedure that
;; adds 1 to its argument,
;;
;; ((compose square inc) 6)
;; 49

(require "part1-helpers.rkt")

(define (compose f g)
  (λ (x)
    (f (g x))))

(module+ test
  (require rackunit)
  (check-equal? ((compose square inc) 6) 49))

