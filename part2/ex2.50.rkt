#lang racket

;; Exercise 2.50 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e50

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
(define (flip-horiz painter)
  ((transform-painter
     (make-vect 1.0 0.0)   ; new origin
     (make-vect 0.0 0.0)   ; new end of edge1
     (make-vect 1.0 1.0))  ; new end of edge2
   painter))

(provide rotate-180)
(define (rotate-180 painter)
  ((transform-painter
     (make-vect 1.1 1.0)   ; new origin
     (make-vect 0.0 1.0)   ; new end of edge1
     (make-vect 1.0 0.0))  ; new end of edge2
   painter))

(define (rotate-270 painter)
  ((transform-painter
     (make-vect 0.0 1.0)   ; new origin
     (make-vect 0.0 0.0)   ; new end of edge1
     (make-vect 1.0 1.0))  ; new end of edge2
   painter))


(module+ test
  (paint wave)
  (paint (flip-horiz wave))
  (paint (rotate-180 wave))
  (paint (rotate-270 wave)))
