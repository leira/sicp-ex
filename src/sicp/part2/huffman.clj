(ns sicp.part2.huffman)

(defn make-leaf [symbol weight]
  (list :leaf symbol weight))
(defn leaf? [object]
  (= (first object) :leaf))
(defn symbol-leaf [x] (second x))
(defn weight-leaf [x] (nth x 2))


(defn symbols [tree]
  (if (leaf? tree)
      (set [(symbol-leaf tree)])
      (nth tree 2)))

(defn weight [tree]
  (if (leaf? tree)
      (weight-leaf tree)
      (nth tree 3)))

(defn make-code-tree [left right]
  (list left
        right
        (clojure.set/union (symbols left)
                           (symbols right))
        (+ (weight left) (weight right))))

(defn left-branch [tree] (first tree))
(defn right-branch [tree] (second tree))


(defn choose-branch [bit branch]
  (cond (= bit 0) (left-branch branch)
        (= bit 1) (right-branch branch)
        :else (throw (Exception. "bad bit: CHOOSE-BRANCH" bit))))

(defn decode [bits tree]
  (defn decode-1 [bits current-branch]
    (if (empty? bits)
        '()
        (let [next-branch
               (choose-branch 
                (first bits)
                current-branch)]
          (if (leaf? next-branch)
              (cons 
               (symbol-leaf next-branch)
               (decode-1 (rest bits) tree))
              (decode-1 (rest bits)
                        next-branch)))))
  (decode-1 bits tree))
