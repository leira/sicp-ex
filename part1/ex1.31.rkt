#lang racket

;; Exercise 1.31:
;;
;; 1. The sum procedure is only the simplest of a vast number of similar
;; abstractions that can be captured as higher-order procedures. Write an
;; analogous procedure called product that returns the product of the values of
;; a function at points over a given range. Show how to define factorial in
;; terms of product. Also use product to compute approximations to π using the
;; formula
;;
;; $$\frac{π}{4} = \frac{2\cdot4\cdot4\cdot6\cdot6\cdot8\cdots}
;;                      {3\cdot3\cdot5\cdot5\cdot7\cdot7\cdots}$$
;;
;; 2. If your product procedure generates a recursive process, write one that
;; generates an iterative process. If it generates an iterative process, write
;; one that generates a recursive process.

(require "part1-helpers.rkt")

(define (product-r term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-r term (next a) next b))))

(module+ test
  (require rackunit)
  (define (test-prod prod)
    (check-equal? (prod identity 1 inc 10) 3628800)
    (check-equal? (prod square 1 inc 10) 13168189440000))
  (test-prod product-r))


(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(module+ test
  (test-prod product))


(define (wallis-pi n)
  (define (term n)
    (if (even? n)
        (/ (+ n 2) (+ n 1))
        (/ (+ n 1) (+ n 2))))
  (* 4 (product term 1 inc n)))

(module+ test
  (check-= (wallis-pi 1000) pi 0.01))

