#lang racket

;; Exercise 2.64 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e64

(require "ex2.63.rkt")

(provide list->tree)
(define (list->tree elements)
  (car (partial-tree 
        elements (length elements))))

;; O(n)
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size 
             (quotient (- n 1) 2)))
        (let ((left-result 
               (partial-tree 
                elts left-size)))
          (let ((left-tree 
                 (car left-result))
                (non-left-elts 
                 (cdr left-result))
                (right-size 
                 (- n (+ left-size 1))))
            (let ((this-entry 
                   (car non-left-elts))
                  (right-result 
                   (partial-tree 
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree 
                     (car right-result))
                    (remaining-elts 
                     (cdr right-result)))
                (cons (make-tree this-entry 
                                 left-tree 
                                 right-tree)
                      remaining-elts))))))))

(module+ test
  (list->tree '(1 3 5 7 9 11)))

