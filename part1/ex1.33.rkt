#lang racket

;; Exercise 1.33: You can obtain an even more general version of accumulate
;; (Exercise 1.32) by introducing the notion of a filter on the terms to be
;; combined. That is, combine only those terms derived from values in the range
;; that satisfy a specified condition. The resulting filtered-accumulate
;; abstraction takes the same arguments as accumulate, together with an
;; additional predicate of one argument that specifies the filter. Write
;; filtered-accumulate as a procedure. Show how to express the following using
;; filtered-accumulate:
;;
;; 1. the sum of the squares of the prime numbers in the interval a to b
;; (assuming that you have a prime? predicate already written)
;;
;; 2. the product of all the positive integers less than n that are relatively
;; prime to n (i.e., all positive integers i<n such that GCD(i,n)=1.

(require "part1-helpers.rkt")
(require "prime.rkt")

(define (filter-accumulate predicate combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (predicate a)
          (combiner (term a)
                    (filter-accumulate predicate combiner
                                       null-value term (next a) next b))
          (filter-accumulate predicate combiner
                             null-value term (next a) next b))))

(module+ test
  (require rackunit)
  (check-equal? (filter-accumulate odd? + 0 cube 1 inc 10) 1225)
  (check-equal? (filter-accumulate even? + 0 identity 1 inc 10) 30)
  (check-equal? (filter-accumulate (lambda (x) #t) * 1 identity 1 inc 10) 3628800))

;; 1.
(define (sum-prime-squares a b)
  (filter-accumulate prime? + 0 square a inc b))

(module+ test
  (check-equal? (sum-prime-squares 1 5) 38)
  (check-equal? (sum-prime-squares 1 100) 65796))

;; 2.
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (prod-rel-primes n)
  (define (rel-prime? a)
    (= (gcd n a) 1))
  (filter-accumulate rel-prime? * 1 identity 1 inc (- n 1)))

(module+ test
  (check-equal? (prod-rel-primes 10) 189))

