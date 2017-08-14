#lang racket

;; Exercise 2.46 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e46

(define (make-vector x y)
  (cons x y))
(define (xcor-vector v)
  (car v))
(define (ycor-vector v)
  (cdr v))

(define (add-vector v w)
  (make-vector
    (+ (xcor-vector v)
       (xcor-vector w))
    (+ (ycor-vector v)
       (ycor-vector w)))) 

(define (sub-vector v w)
  (make-vector
    (- (xcor-vector v)
       (xcor-vector w))
    (- (ycor-vector v)
       (ycor-vector w)))) 

(define (scale-vector s v)
  (make-vector
    (* s (xcor-vector v))
    (* s (ycor-vector v))))

(module+ test
  (require rackunit)
  (let ((v1 (make-vector 4 5))
        (v2 (make-vector 2 1)))
    (check-equal? (add-vector v1 v2) (make-vector 6 6))
    (check-equal? (sub-vector v1 v2) (make-vector 2 4))
    (check-equal? (scale-vector 2 v1) (make-vector 8 10))))

