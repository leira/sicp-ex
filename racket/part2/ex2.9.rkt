#lang racket

;; Exercise 2.9 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e9

(require "ex2.7.rkt")
(require "ex2.8.rkt")

(define (width-interval interval)
  (/ (- (upper-bound interval)
        (lower-bound interval))
     2))
(module+ test
  (require rackunit)
  (define x (make-interval 1 2))
  (define y (make-interval -1 2))
  (check-equal? (width-interval x) 1/2)
  (check-equal? (width-interval y) 3/2))


(define (add-width w1 w2)
  (+ w1 w2))
(module+ test
  (check-equal? (add-width (width-interval x)
                           (width-interval y))
                (width-interval (add-interval x y))))


;; i1 - i2 = i1 + (-i2), (-i2)'s width is same as i2,
;; so sub-width is same as add-width
(define (sub-width w1 w2)
  (add-width w1 w2))
(module+ test
  (check-equal? (sub-width (width-interval x)
                           (width-interval y))
                (width-interval (sub-interval x y))))


;; y and z has same width, but xy and xz has different width, so width of
;; mul-interval is not a function of just widths of the two intervals
(module+ test
  (define z (make-interval 1 4))
  (check-equal? (width-interval y) (width-interval z))
  (check-not-equal? (width-interval (mul-interval x y))
                    (width-interval (mul-interval x z))))

;; same applies to x/y and x/z, so width of div-interval is not a function of
;; just widths of the two intervals
(module+ test
  (check-not-equal? (width-interval (div-interval x y))
                    (width-interval (div-interval x z))))

