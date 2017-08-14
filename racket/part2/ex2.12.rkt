#lang racket

;; Exercise 2.12 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e12

(require "ex2.7.rkt")

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) 
        (upper-bound i)) 
     2))

(define (width i)
  (/ (- (upper-bound i) 
        (lower-bound i)) 
     2))

(define (make-center-percent c p)
  (let ((w (abs (* c p))))
    (make-center-width c w)))

(define (percent i)
  (abs (/ (width i) (center i))))

(module+ test
  (require rackunit)
  (check-equal? (make-center-percent 10.0 0.05) (make-center-width 10.0 0.5))
  (check-equal? (percent (make-center-width 10.0 0.5)) 0.05)
  (check-equal? (make-center-percent -10.0 0.05) (make-center-width -10.0 0.5))
  (check-equal? (percent (make-center-width -10.0 0.5)) 0.05))

