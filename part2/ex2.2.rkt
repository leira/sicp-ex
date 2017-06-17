#lang racket

;; Exercise 2.2 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e2

(provide make-segment)
(define (make-segment start end)
  (cons start end))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

(provide make-point)
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

(define (midpoint-segment s)
  (let ((sp (start-segment s))
        (ep (end-segment s)))
    (make-point (average (x-point sp)
                         (x-point ep))
                (average (y-point sp)
                         (y-point ep)))))

(module+ test
  (require rackunit)
  (check-equal? (midpoint-segment
                  (make-segment (make-point 0 0)
                                (make-point 2 2)))
                (make-point 1 1)))

;; length
(provide length-segment)
(define (length-segment seg)
  (let ((sp (start-segment seg))
        (ep (end-segment seg)))
    (let ((dx (- (x-point ep)
                 (x-point sp)))
          (dy (- (y-point ep)
                 (y-point sp))))
      (sqrt (+ (square dx) (square dy))))))

(module+ test
  (check-equal? (length-segment
                  (make-segment (make-point 0 0)
                                (make-point 2 0)))
                2)
  (check-equal? (length-segment
                  (make-segment (make-point 0 0)
                                (make-point 1 2)))
                (sqrt 5)))
  
(provide average)
(define (average . args)
  (/ (apply + args) (length args)))

(define (square x)
  (* x x))

