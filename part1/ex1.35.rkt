#lang racket

;; Exercise 1.35: Show that the golden ratio $\varphi$ (1.2.2) is a fixed point
;; of the transformation $x \mapsto 1 + 1/x$, and use this fact to compute
;; $\varphi$ by means of the fixed-point procedure.

(require "part1-helpers.rkt")

(define (golden-ratio precision)
  (fixed-point (λ (x) (+ 1 (/ 1 x))) 1.0 precision))

(module+ test
  (require rackunit)
  (define precision 0.001)
  (check-= (golden-ratio precision) 1.618 precision))

