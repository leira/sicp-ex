;; Exercise 2.67 http://sarabander.github.io/sicp/html/2_002e3.xhtml#Exercise-2_002e67

(ns sicp.part2.ex67
  (:require [clojure.test :refer :all]
            [sicp.part2.huffman :refer :all]))

(deftest decode-sample
  (let [sample-tree
         (make-code-tree
          (make-leaf 'A 4)
          (make-code-tree
           (make-leaf 'B 2)
           (make-code-tree 
            (make-leaf 'D 1)
            (make-leaf 'C 1))))
        sample-message
          '(0 1 1 0 0 1 0 1 0 1 1 1 0)]
  (is (=  '(A D     A B   B   C     A) (decode sample-message sample-tree)))))
