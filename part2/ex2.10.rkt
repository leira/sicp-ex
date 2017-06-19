#lang racket

;; Exercise 2.10 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e10

(require "ex2.7.rkt")

(provide div-interval)
(define (div-interval x y)
  (if (<= (* (upper-bound y)
             (lower-bound y)) 0)
      (error "divided by span of 0")
      ((mul-interval x
                     (make-interval
                       (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y)))))))

(module+ test
  (require rackunit)
  (check-exn exn:fail? 
             (λ ()
               (div-interval (make-interval 1 2)
                             (make-interval -1 1))))
  (check-exn exn:fail? 
             (λ ()
               (div-interval (make-interval 1 2)
                             (make-interval 0 1)))))

