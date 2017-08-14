#lang racket

;; Exercise 2.45 http://sarabander.github.io/sicp/html/2_002e2.xhtml#Exercise-2_002e45

(require sicp-pict)
(require "ex2.49.rkt")

(provide split)
(define (split first-split second-split)
  (define (sp painter n)
    (if (= n 0)
        painter
        (let ((smaller (sp painter
                           (- n 1))))
          (first-split painter
                       (second-split smaller smaller)))))
  sp)

(provide right-split)
(define right-split (split beside below))
(provide up-split)
(define up-split (split below beside))

(module+ test
  (paint (right-split wave 5))
  (paint (up-split einstein 5)))

