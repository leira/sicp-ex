#lang racket

;; Exercise 2.51 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e51

(require sicp-pict)
(require "ex2.49.rkt")

;; the transform-painter used here is from sicp-pict, which returns a procedure
;; which can be used to transform painters
;; (define (transform-painter origin corner1 corner2)
;;   (lambda (painter)
;;     (compose painter
;; 	     (make-relative-frame
;; 	      origin
;; 	      corner1
;; 	      corner2))))
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom ((transform-painter
                           (make-vect 0.0 0.0)
                           (make-vect 1.0 0.0)
                           split-point) painter1))
          (paint-top    ((transform-painter
                           split-point
                           (make-vect 1.0 0.5)
                           (make-vect 0.0 1.0)) painter2)))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))
(module+ test
  (paint (below wave einstein)))

(define (below-r painter1 painter2)
  (rotate90 (beside (rotate270 painter1)
                     (rotate270 painter2))))
(module+ test
  (paint (below-r wave einstein)))
