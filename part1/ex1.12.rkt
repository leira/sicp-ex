#lang racket/base

;; Exercise 1.12: The following pattern of numbers is called Pascal’s triangle.
;;
;;         1
;;       1   1
;;     1   2   1
;;   1   3   3   1
;; 1   4   6   4   1
;;       . . .
;;
;; The numbers at the edge of the triangle are all 1, and each number inside the
;; triangle is the sum of the two numbers above it.35 Write a procedure that
;; computes elements of Pascal’s triangle by means of a recursive process.

(define (pascal-triangle-element m n)
  (cond ((= n 0) 1)
        ((= n m) 1)
        ((> n m) 0)
        (else (+ (pascal-triangle-element (- m 1) (- n 1))
                 (pascal-triangle-element (- m 1) n)))))

(module+ test
  (require rackunit)
  (check-equal? (pascal-triangle-element 0 0) 1)
  (check-equal? (pascal-triangle-element 0 1) 0)
  (check-equal? (pascal-triangle-element 1 1) 1)
  (check-equal? (pascal-triangle-element 2 1) 2)
  (check-equal? (pascal-triangle-element 4 2) 6)
  (check-equal? (pascal-triangle-element 5 1) 5)
  (check-equal? (pascal-triangle-element 5 2) 10))

