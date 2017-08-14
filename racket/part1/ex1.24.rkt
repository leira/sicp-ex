#lang racket/base

;; Exercise 1.24: Modify the timed-prime-test procedure of Exercise 1.22 to use
;; fast-prime? (the Fermat method), and test each of the 12 primes you found in
;; that exercise. Since the Fermat test has $\Theta (\log n)$ growth, how would
;; you expect the time to test primes near 1,000,000 to compare with the time
;; needed to test primes near 1000? Do your data bear this out? Can you explain
;; any discrepancy you find?

(require "prime.rkt")

(search-for-primes fast-prime? 1000 3)
(search-for-primes fast-prime? 10000 3)
(search-for-primes fast-prime? 100000 3)
(search-for-primes fast-prime? 1000000 3)
(search-for-primes fast-prime? 1000000000 3)

