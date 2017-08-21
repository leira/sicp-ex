;; Exercise 2.73 http://sarabander.github.io/sicp/html/2_002e4.xhtml#Exercise-2_002e73

(ns sicp.part2.ex73
  (:require [sicp.part2.dispatch :refer :all]
            [clojure.test :refer :all]))

;; 1. number and varible doesn't have operator as tag, so they needs to be
;;    checked seperately

(declare variable? same-variable? operator operands)

(defn deriv [exp var]
   (cond (number? exp) 0

         (variable? exp) 
         (if (same-variable? exp var) 1 0)

         :else ((get-op 'deriv (operator exp)) 
                (operands exp) 
                var)))


(defn- operator [exp] (first exp))
(defn- operands [exp] (rest exp))

(defn- variable? [x] (symbol? x))
(defn- same-variable? [v1 v2]
  (and (variable? v1)
       (variable? v2)
       (= v1 v2)))

(defn- =number? [exp num]
  (and (number? exp) (= exp num)))

(defn- right-operand [oprds op]
  (let [right (rest oprds)]
    (if (= (count right) 1)
        (first right)
        (cons op right))))


(defn- install-deriv-sum []
  (letfn [(make-sum [a1 a2]
            (cond (=number? a1 0) a2
                  (=number? a2 0) a1
                  (and (number? a1) (number? a2)) (+ a1 a2)
                  :else (list '+ a1 a2)))

          (addend [s] (first s))
          (augend [s] (right-operand s '+))

          (deriv-sum [oprds var]
            (make-sum (deriv (addend oprds) var)
                      (deriv (augend oprds) var)))]
    (put-op 'deriv '+ deriv-sum)
    (put-op 'make '+ make-sum)))


(defn- install-deriv-product []
  (letfn [(make-product [m1 m2]
            (cond (or (=number? m1 0) 
                      (=number? m2 0)) 0
                  (=number? m1 1) m2
                  (=number? m2 1) m1
                  (and (number? m1)
                      (number? m2)) (* m1 m2)
                  :else (list '* m1 m2)))

          (multiplier [s] (first s))
          (multiplicand [s] (right-operand s '*))

          (deriv-product [oprds var]
            ((get-op 'make '+)
             (make-product 
              (multiplier oprds)
              (deriv (multiplicand oprds) var))
             (make-product 
              (deriv (multiplier oprds) var)
              (multiplicand oprds))))]
    (put-op 'deriv '* deriv-product)
    (put-op 'make '* make-product)))


(defn install-deriv-operators []
  (install-deriv-sum)
  (install-deriv-product))

(deftest deriv-test
  (install-deriv-operators)
  (is (= 1
         (deriv '(+ 5 x) 'x) 1))
  (is (= 1
         (deriv '(+ y 5 x) 'x) 1))
  (is (= '(+ 1 y)
         (deriv '(+ x 5 (* x y)) 'x)))
  (is (= '(+ (* x y) (* y (+ x 3)))
         (deriv '(* x y (+ x 3)) 'x)))
  (is (= '(+ (+ (* x y) (* y (+ x 3))) 1)
         (deriv '(+ (* x y (+ x 3)) x 5) 'x))))
