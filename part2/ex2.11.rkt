#lang racket

;; Exercise 2.11 http://sarabander.github.io/sicp/html/2_002e1.xhtml#Exercise-2_002e11

(require "ex2.7.rkt")

(define (mul-interval x y)
  (define (neg-neg-interval? x)
    (and (< (lower-bound x) 0)
         (< (upper-bound x) 0)))
  (define (nneg-nneg-interval? x)
    (and (>= (lower-bound x) 0)
         (>= (upper-bound x) 0)))
  (let ((x-lo (lower-bound x))
        (x-up (upper-bound x))
        (y-lo (lower-bound y))
        (y-up (upper-bound y)))
    (cond ((neg-neg-interval? x)
             (cond ((neg-neg-interval? y)
                      (make-interval (* x-up y-up) (* x-lo y-lo)))
                   ((nneg-nneg-interval? y)
                      (make-interval (* x-lo y-up) (* x-up y-lo)))
                   (else
                      (make-interval (* x-lo y-up) (* x-lo y-lo)))))
          ((nneg-nneg-interval? x)
             (cond ((neg-neg-interval? y)
                      (make-interval (* x-up y-lo) (* x-lo y-up)))
                   ((nneg-nneg-interval? y)
                      (make-interval (* x-lo y-lo) (* x-up y-up)))
                   (else
                      (make-interval (* x-up y-lo) (* x-up y-up)))))
          (else
             (cond ((neg-neg-interval? y)
                      (make-interval (* x-up y-lo) (* x-lo y-lo)))
                   ((nneg-nneg-interval? y)
                      (make-interval (* x-lo y-up) (* x-up y-up)))
                   (else
                      (make-interval (min (* x-up y-lo) (* x-lo y-up))
                                     (max (* x-lo y-lo) (* x-up y-up)))))))))

(module+ test
  (require rackunit)
  (let ((nn (make-interval -3 -2))
        (pp (make-interval 2 3))
        (np (make-interval -2 3))
        (np2 (make-interval -4 5))
        (nz (make-interval -2 0))
        (zp (make-interval 0 3)))
    (check-equal? (mul-interval nn nn) (make-interval 4 9))
    (check-equal? (mul-interval nn pp) (make-interval -9 -4))
    (check-equal? (mul-interval nn np) (make-interval -9 6))

    (check-equal? (mul-interval pp nn) (make-interval -9 -4))
    (check-equal? (mul-interval pp pp) (make-interval 4 9))
    (check-equal? (mul-interval pp np) (make-interval -6 9))

    (check-equal? (mul-interval np nn) (make-interval -9 6))
    (check-equal? (mul-interval np pp) (make-interval -6 9))
    (check-equal? (mul-interval np np2) (make-interval -12 15))

    (check-equal? (mul-interval nz nn) (make-interval 0 6))
    (check-equal? (mul-interval nz pp) (make-interval -6 0))
    (check-equal? (mul-interval nz np) (make-interval -6 4))

    (check-equal? (mul-interval zp nn) (make-interval -9 0))
    (check-equal? (mul-interval zp pp) (make-interval 0 9))
    (check-equal? (mul-interval zp np) (make-interval -6 9))))

