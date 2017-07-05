#lang racket

;; Exercise 2.63 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e63

(provide entry)
(define (entry tree) (car tree))
(provide left-branch)
(define (left-branch tree) (cadr tree))
(provide right-branch)
(define (right-branch tree) (caddr tree))
(provide make-tree)
(define (make-tree entry left right)
  (list entry left right))
  
;; O(n*log(n)), append!
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append 
       (tree->list-1 
        (left-branch tree))
       (cons (entry tree)
             (tree->list-1 
              (right-branch tree))))))

;; O(n)
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list 
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list 
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))

(provide tree->list)
(define tree->list tree->list-2)

(define t1 
  (make-tree 7
    (make-tree 3
      (make-tree 1 null null)
      (make-tree 5 null null))
    (make-tree 9
      null
      (make-tree 11 null null))))

(define t2 
  (make-tree 3
    (make-tree 1 null null)
    (make-tree 7
      (make-tree 5 null null)
      (make-tree 9
        null
        (make-tree 11 null null)))))

(define t3 
  (make-tree 5
    (make-tree 3
      (make-tree 1 null null)
      null)
    (make-tree 9
      (make-tree 7 null null)
      (make-tree 11 null null))))

(define trees (list t1 t2 t3))

(module+ test
  (require rackunit)
  (for-each (λ (t)
              (check-equal? (tree->list-1 t) '(1 3 5 7 9 11)))
            trees)
  (for-each (λ (t)
              (check-equal? (tree->list-2 t) '(1 3 5 7 9 11)))
            trees)
  )

