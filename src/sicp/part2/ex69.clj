;; Exercise 2.69 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e69

(ns sicp.part2.ex69
  (:require [clojure.test :refer :all]
            [sicp.part2.huffman :refer :all]))

(defn adjoin-set [x set]
  (cond (empty? set) (list x)
        (< (weight x) (weight (first set))) (cons x set)
        :else (cons (first set)
                    (adjoin-set x (rest set)))))

(defn make-leaf-set [pairs]
  (if (empty? pairs)
      '()
      (let [pair (first pairs)]
        (adjoin-set 
         (make-leaf (first pair)    ; symbol
                    (second pair))    ; frequency
         (make-leaf-set (rest pairs))))))

(defn successive-merge [node-set] 
  (cond (empty? node-set) nil
        (empty? (rest node-set)) (first node-set)
        :else
          (let [[l r & s] node-set
                tree (make-code-tree l r)]
            (recur (adjoin-set tree s)))))

(defn generate-huffman-tree [pairs]
  (successive-merge 
   (make-leaf-set pairs)))


(deftest generate-tree
  (let [sample-tree
         (make-code-tree
          (make-leaf 'A 4)
          (make-code-tree
           (make-leaf 'B 2)
           (make-code-tree 
            (make-leaf 'D 1)
            (make-leaf 'C 1))))
        sample-pairs [['A 4] ['C 1] ['D 1] ['B 2]]]
    (is (= sample-tree (generate-huffman-tree sample-pairs)))))
