#lang racket

;; Exercise 1.37:
;;
;; 1. An infinite *continued fraction* is an expression of the form
;;
;; $$f = \frac{N_1}{D_1+\frac{N_2}{D_2+\frac{N_3}{D_3+\cdots}}}$$
;;
;; As an example, one can show that the infinite continued fraction expansion
;; with the $N_i$ and the $D_i$ all equal to 1 produces $1/\varphi$, where
;; $varphi$ is the golden ratio (described in 1.2.2). One way to approximate an
;; infinite continued fraction is to truncate the expansion after a given number
;; of terms. Such a truncation -- a so-called finite continued fraction *k-term
;; finite continued fraction* —- has the form
;;
;; $$\frac{N_1}{D_1+\frac{N_2}{\ddots+\frac{N_k}{D_k}}}$$
;;
;; Suppose that n and d are procedures of one argument (the term index i) that
;; return the $N_i$ and $D_i$ of the terms of the continued fraction. Define a
;; procedure `cont-frac` such that evaluating `(cont-frac n d k)` computes the
;; value of the k-term finite continued fraction. Check your procedure by
;; approximating $1/\varphi$ using
;;
;; (cont-frac (lambda (i) 1.0)
;;            (lambda (i) 1.0)
;;            k)
;;
;; for successive values of k. How large must you make k in order to get an
;; approximation that is accurate to 4 decimal places?
;;
;; 2. If your `cont-frac` procedure generates a recursive process, write one that
;; generates an iterative process. If it generates an iterative process, write
;; one that generates a recursive process.

;; 1.
(define (cont-frac-r n d k)
  ;; not correct
  (if (= k 0)
      0
      (/ (n k)
         (+ (d k)
            (cont-frac-r n d (- k 1))))))

(define (inverse-golden-ratio cont-frac k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))

(module+ test
  (require rackunit)
  (check-= (inverse-golden-ratio cont-frac-r 11) 0.61803398875 0.0001))


;; 2.
(define (cont-frac-i n d k)
  (define (iter i deeper-term)
    (if (= i 0)
        deeper-term
        (iter (- i 1) 
              (/ (n k)
                 (+ (d k) deeper-term)))))
  (iter k 0))

(module+ test
  (check-= (inverse-golden-ratio cont-frac-i 11) 0.61803398875 0.0001))

