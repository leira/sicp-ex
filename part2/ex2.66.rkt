#lang racket

;; Exercise 2.65 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e65

(require "ex2.63.rkt")
(require "ex2.64.rkt")

(define (make-record key content)
  (cons key content))
(define (key record)
  (car record))
(define (content record)
  (cdr record))

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
      false
      (let ((current-key (key (entry set-of-records))))
        (cond ((= given-key current-key) (entry set-of-records))
              ((< given-key current-key)
               (lookup given-key (left-branch set-of-records)))
              ((> given-key current-key)
               (lookup given-key (right-branch set-of-records)))))))

(module+ test
  (require rackunit)
  (define records
    (list->tree (list (make-record 1 'Afghanistan)
                      (make-record 2 'Afghanistan)
                      (make-record 3 'Albania)
                      (make-record 4 'Algeria)
                      (make-record 5 'Andorra)
                      (make-record 6 'Angola)
                      (make-record 7 'Antigua&Barbuda)
                      (make-record 8 'Argentina)
                      (make-record 9 'Armenia)
                      (make-record 10 'Aruba)
                      (make-record 11 'Australia)
                      (make-record 12 'Austria)
                      (make-record 13 'Azerbaijan)
                      )))
  (check-false (lookup 15 records))
  (check-equal? (content (lookup 6 records)) 'Angola)
  )

