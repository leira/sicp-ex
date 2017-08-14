#lang racket/base

;; Exercise 1.30: The sum procedure above generates a linear recursion. The
;; procedure can be rewritten so that the sum is performed iteratively. Show how
;; to do this by filling in the missing expressions in the following definition:
;;
;; (define (sum term a next b)
;;   (define (iter a result)
;;     (if ⟨??⟩
;;         ⟨??⟩
;;         (iter ⟨??⟩ ⟨??⟩)))
;;   (iter ⟨??⟩ ⟨??⟩))
;; 
;; The recursive version of sum:
;;
;; (define (sum term a next b)
;;   (if (> a b)
;;       0
;;       (+ (term a)
;;          (sum term (next a) next b))))

(require "part1-helpers.rkt")

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(module+ test
  (require rackunit)
  (check-equal? (sum cube 1 inc 10) 3025)
  (check-equal? (sum identity 1 inc 10) 55))

