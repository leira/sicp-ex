#lang racket/base

(require "part1-helpers.rkt")

(provide prime?)
(define (prime? n)
  (if (= n 1) #f (= n (smallest-divisor n))))

(provide prime-odd?)
(define (prime-odd? n)
  (if (= n 1) #f (= n (smallest-divisor-odd n))))

(provide fermat-test)
(define (fermat-test n a)
  (= (expmod a n n) a))

(provide fast-prime?)
(define (fast-prime? n)
  (fast-prime-times? n (min n 20)))

(provide timed-prime-test)
(define (timed-prime-test prime? n)
  (newline)
  (display n)
  (start-prime-test n prime? (runtime)))

(provide search-for-primes)
(define (search-for-primes prime? n count)
  (when (> count 0)
        (if (even? n)
            (search-for-primes prime? (+ n 1) count)
            (if (timed-prime-test prime? n)
                (search-for-primes prime? (+ n 2) (- count 1))
                (search-for-primes prime? (+ n 2) count)))))

(define (start-prime-test n prime? start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))
      #f))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  #t)


(define (smallest-divisor n)
  (define (next n)
          (+ n 1))
  (find-divisor n next 2))

(define (smallest-divisor-odd n)
  (define (next n)
          (if (= n 2) 3 (+ n 2)))
  (find-divisor n next 2))

(define (find-divisor n next test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               next
               (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (fast-prime-times? n times)
  (cond ((= times 0) #t)
        ((fermat-test n (+ 1 (random (- n 1)))) 
         (fast-prime-times? n (- times 1)))
        (else #f)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(module+ test
  (require rackunit)
  (define (test-primes prime?)
    (check-true (prime? 2))
    (check-true (prime? 3))
    (check-false (prime? 102))
    (check-true (prime? 103)))
  (test-primes prime?) 
  (test-primes prime-odd?) 
  (test-primes fast-prime?))

