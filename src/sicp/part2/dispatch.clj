(ns sicp.part2.dispatch)

(def ^{:private true} op-table (atom {}))

(defn put-op [op type item]
  (if (get-in @op-table [op type])
      (throw (Exception. (str "Conflict! -- " op " on " type " already defined")))
      (swap! op-table (fn [table] (assoc-in table [op type] item)))))

(defn get-op [op type]
  (or (get-in @op-table [op type])
      (throw (Exception. (str "Not Found! -- " op " on " type)))))
