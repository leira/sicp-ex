#lang racket

;; Exercise 1.32:
;;
;; 1. Show that sum and product (Exercise 1.31) are both special cases of a
;; still more general notion called accumulate that combines a collection of
;; terms, using some general accumulation function:
;;
;; (accumulate
;;   combiner null-value term a next b)
;;
;; Accumulate takes as arguments the same term and range specifications as sum
;; and product, together with a combiner procedure (of two arguments) that
;; specifies how the current term is to be combined with the accumulation of
;; the preceding terms and a null-value that specifies what base value to use
;; when the terms run out. Write accumulate and show how sum and product can
;; both be defined as simple calls to accumulate.
;;
;; 2. If your accumulate procedure generates a recursive process, write one that
;; generates an iterative process. If it generates an iterative process, write
;; one that generates a recursive process.

(require "part1-helpers.rkt")

(define (accumulate-r combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-r combiner null-value term (next a) next b))))

(module+ test
  (require rackunit)
  (define (test-accumulate accum)
    (define (sum term a next b)
      (accum + 0 term a next b))
    (define (product term a next b)
      (accum * 1 term a next b))
    (check-equal? (sum cube 1 inc 10) 3025)
    (check-equal? (sum identity 1 inc 10) 55)
    (check-equal? (product identity 1 inc 10) 3628800)
    (check-equal? (product square 1 inc 10) 13168189440000))
  (test-accumulate accumulate-r))

;; not exact the same, this is actually a foldl
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(module+ test
  (test-accumulate accumulate))

