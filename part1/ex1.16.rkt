#lang racket/base

;; Exercise 1.16: Design a procedure that evolves an iterative exponentiation
;; process that uses successive squaring and uses a logarithmic number of steps,
;; as does fast-expt. (Hint: Using the observation that
;; $(b^{n/2})^2=(b^2)^{n/2}$, keep, along with the exponent nn and the base b,
;; an additional state variable a, and define the state transformation in such
;; a way that the product $ab^n$ is unchanged from state to state. At the
;; beginning of the process a is taken to be 1, and the answer is given by the
;; value of a at the end of the process. In general, the technique of defining
;; an invariant quantity that remains unchanged from state to state is a
;; powerful way to think about the design of iterative algorithms.)

(require "part1-helpers.rkt")

(define (fast-expt b n)
  (define (expt-iter a b n)
    ; a: state, b: base, n: exponent
    (cond ((= n 0) 
           a)
          ((even? n) 
           (expt-iter a (square b) (/ n 2)))
          (else 
           (expt-iter (* a b) b (- n 1)))))
  (expt-iter 1 b n))

(module+ test
  (require rackunit)
  (check-equal? (fast-expt 2 0) 1)
  (check-equal? (fast-expt 3 1) 3)
  (check-equal? (fast-expt 2 4) 16)
  (check-equal? (fast-expt 2 5) 32))

