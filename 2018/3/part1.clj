(require '[clojure.string :as str]
         '[clojure.pprint :as ppr])

(def input (str/split-lines (str/trim (slurp "input"))))

(defn build-claim [string]
  (zipmap [:id :x :y :w :h](map read-string (re-seq #"\d+" string))))

(defn expand-claim [claim]
  (for [x (range (:x claim) (+ (:x claim) (:w claim)))
        y (range (:y claim) (+ (:y claim) (:h claim)))]
    [x y]))

(defn dups [seq]
  (for [[square freq] (frequencies seq)
        :when (> freq 1)]
   square))

(let [claims (map build-claim input)
      expanded-claims (map expand-claim claims)]
  (ppr/pprint
    (count
      (dups
        (apply concat expanded-claims)))))
