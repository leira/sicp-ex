#lang racket/base

;; Exercise 1.27: Demonstrate that the Carmichael numbers listed in Footnote 47
;; really do fool the Fermat test. That is, write a procedure that takes an
;; integer n and tests whether $a^n$ is congruent to a modulo n for every a<n,
;; and try your procedure on the given Carmichael numbers.

;; Footnot 47: Numbers that fool the Fermat test are called Carmichael numbers,
;; and little is known about them other than that they are extremely rare. There
;; are 255 Carmichael numbers below 100,000,000. The smallest few are 561, 1105,
;; 1729, 2465, 2821, and 6601. In testing primality of very large numbers chosen
;; at random, the chance of stumbling upon a value that fools the Fermat test is
;; less than the chance that cosmic radiation will cause the computer to make an
;; error in carrying out a “correct” algorithm. Considering an algorithm to be
;; inadequate for the first reason but not for the second illustrates the
;; difference between mathematics and engineering.

(require "prime.rkt")

(define (pass-fermat-test? x)
  (define (iter x n)
    (if (= n x)
        #t
        (if (fermat-test x n) 
            (iter x (+ n 1))
            #f)))
  (iter x 2))

(define (carmichael-number? x)
  (and (not (prime-odd? x)) (pass-fermat-test? x)))

(module+ test
  (require rackunit)
  (check-true (carmichael-number? 561))
  (check-true (carmichael-number? 1105))
  (check-true (carmichael-number? 1729))
  (check-true (carmichael-number? 2465))
  (check-true (carmichael-number? 2821))
  (check-true (carmichael-number? 6601)))

