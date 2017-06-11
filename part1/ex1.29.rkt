#lang racket/base

;; Exercise 1.29: Simpson’s Rule is a more accurate method of numerical
;; integration than the method illustrated above. Using Simpson’s Rule, the
;; integral of a function f between a and b is approximated as
;;
;; $$\frac{h}{3} (y_0+4y_1+2y_2+4y_3+2y_4+\cdots+2y_{n−2}+4y_{n−1}+y_n)$$
;;
;; where $h=\frac{(b−a)}{n}, for some even integer n, and $y_k=f(a+kh)$.
;; (Increasing n increases the accuracy of the approximation.) Define a
;; procedure that takes as arguments f, a, b, and nn and returns the value of
;; the integral, computed using Simpson’s Rule. Use your procedure to integrate
;; cube between 0 and 1 (with $n=100$ and $n=1000$), and compare the results to
;; those of the integral procedure shown above.

(define (round-to-next-even x) 
  (+ x (remainder x 2))) 

(define (simpson-integral f a b n)
  (define fixed-n (round-to-next-even n))
  (define (coef k)
    (cond ((= k fixed-n) 1)
          ((= k 0) 1)
          ((even? k) 2)
          (else 4)))
  (define h (exact->inexact (/ (- b a) fixed-n)))
  (define (iter sum k)
    (define y (f (+ a (* k h))))
    (if (< k 0)
      sum
      (iter (+ sum (* (coef k) y))
            (- k 1))))
  (* (/ h 3) (iter 0 fixed-n)))
  
(define (cube x) (* x x x))

(module+ test
  (require rackunit)
  (check-= (simpson-integral cube 0 1 100) 0.25 0.00001)
  (check-= (simpson-integral cube 0 1 1000) 0.25 0.00001))

