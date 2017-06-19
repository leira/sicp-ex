#lang racket

;; Exercise 2.8 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e8

(require "ex2.7.rkt")

(provide sub-interval)
(define (sub-interval x y)
  (make-interval (- (lower-bound x) 
                    (upper-bound y))
                 (- (upper-bound x) 
                    (lower-bound y))))

(module+ test
  (require rackunit)
  (let ((x (make-interval 1 2))
        (y (make-interval 0 1)))
    (check-equal? (sub-interval x y) (make-interval 0 2))
    (check-equal? (sub-interval y x) (make-interval -2 0)))
  (let ((x (make-interval -2 -1))
        (y (make-interval -4 -3)))
    (check-equal? (sub-interval x y) (make-interval 1 3))
    (check-equal? (sub-interval y x) (make-interval -3 -1)))
  (let ((x (make-interval 1 2))
        (y (make-interval -4 -3)))
    (check-equal? (sub-interval x y) (make-interval 4 6))
    (check-equal? (sub-interval y x) (make-interval -6 -4))))

