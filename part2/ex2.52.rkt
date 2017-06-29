#lang racket

;; Exercise 2.51 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e51

(require sicp-pict)
(require "ex2.49.rkt")
(require "ex2.45.rkt")

;; 1.
(define wave-smile
   (segments->painter (list 
                        (make-segment (make-vect .25 0) (make-vect .35 .5))
                        (make-segment (make-vect .35 .5) (make-vect .3 .6))
                        (make-segment (make-vect .3 .6) (make-vect .15 .4))
                        (make-segment (make-vect .15 .4) (make-vect 0 .65))
                        (make-segment (make-vect 0 .85) (make-vect .15 .6))
                        (make-segment (make-vect .15 .6) (make-vect .3 .65))
                        (make-segment (make-vect .3 .65) (make-vect .4 .65))
                        (make-segment (make-vect .4 .65) (make-vect .35 .85))
                        (make-segment (make-vect .35 .85) (make-vect .4 1))
                        (make-segment (make-vect .6 1) (make-vect .65 .85))
                        (make-segment (make-vect .65 .85) (make-vect .6 .65))
                        (make-segment (make-vect .6 .65) (make-vect .75 .65))
                        (make-segment (make-vect .75 .65) (make-vect 1 .35))
                        (make-segment (make-vect 1 .15) (make-vect .6 .45))
                        (make-segment (make-vect .6 .45) (make-vect .75 0))
                        (make-segment (make-vect .6 0) (make-vect .5 .3))
                        (make-segment (make-vect .5 .3) (make-vect .4 0))
                        ;; a smile
                        (make-segment (make-vect .4 0.75) (make-vect .5 .7))
                        (make-segment (make-vect .5 .7) (make-vect .6 0.75))
                        )))
(module+ test
  (paint wave-smile))

;; 2.
(define (corner-split-s n)
  (define (us n) (λ (painter) (up-split painter n)))
  (define (rs n) (λ (painter) (right-split painter n)))
    (if (= n 0)
        identity
        (square-of-four (us (- n 1))
                        (corner-split-s (- n 1))
                        identity
                        (rs (- n 1)))))
(module+ test
  (paint-hi-res ((corner-split-s 4) wave-smile)))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) 
                       (tr painter)))
          (bottom (beside (bl painter) 
                          (br painter))))
      (below bottom top))))

;; 3.
(define (square-limit-s painter n)
  (let ((corner ((corner-split-s n) painter)))
    ((square-of-four flip-horiz identity rotate180 flip-vert) corner)))
(module+ test
  (paint-hi-res (square-limit-s wave-smile 4))
  (paint-hi-res (square-limit-s einstein 4)))

(define (square-limit-c n)
  (compose (square-of-four flip-horiz identity rotate180 flip-vert) (corner-split-s n)))
(module+ test
  (paint-hi-res ((square-limit-c 4) wave-smile)))