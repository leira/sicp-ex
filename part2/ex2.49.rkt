#lang racket

;; Exercise 2.49 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e49

(require sicp-pict)

;; to make all segments visible, rather than use 0 and 1, use 0.01 0.99 here
(define outline
  (segments->painter (list (make-segment (make-vect 0.01 0.01) (make-vect 0.01 0.99))
                           (make-segment (make-vect 0.01 0.99) (make-vect 0.99 0.99))
                           (make-segment (make-vect 0.99 0.99) (make-vect 0.99 0.01))
                           (make-segment (make-vect 0.99 0.01) (make-vect 0.01 0.01)))))

(define X
  (segments->painter (list (make-segment (make-vect 0 0) (make-vect 1 1))
                           (make-segment (make-vect 0 1) (make-vect 1 0)))))

(define diamond
  (segments->painter (list (make-segment (make-vect 0 0.5) (make-vect 0.5 0))
                           (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
                           (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
                           (make-segment (make-vect 0.5 1) (make-vect 0 0.5)))))

(provide wave)
;; too many segments, copied most from http://community.schemewiki.org/?sicp-ex-2.49
(define wave 
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
                        )))

(module+ test
  (paint outline)
  (paint X)
  (paint diamond)
  (paint wave))
