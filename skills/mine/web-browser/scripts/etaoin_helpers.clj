(ns etaoin-helpers "Compact etaoin error handling.")

(def etaoin-last-error
  "Last etaoin exception. @etaoin-last-error to inspect."
  (atom nil))

(defn etaoin-err
  "Concise summary from etaoin ExceptionInfo."
  [^Exception e]
  (let [data (ex-data e)]
    (cond
      (= :etaoin/timeout (:type data))
      {:error :timeout
       :message (:message data)
       :timeout (:timeout data)}

      (= :etaoin/http-error (:type data))
      {:error (get-in data [:response :value :error])
       :message (get-in data [:response :value :message])
       :selector (:payload data)}

      :else
      {:error (or (:type data) (.getMessage e))})))

(defmacro try-e
  "Wrap etaoin calls. Catches errors, prints summary, stores full exception in etaoin-last-error."
  [& body]
  `(try
     ~@body
     (catch clojure.lang.ExceptionInfo e#
       (reset! etaoin-last-error e#)
       (let [summary# (etaoin-err e#)]
         (println "ETAOIN ERROR:" (pr-str summary#))
         (println "@etaoin-last-error for full exception")))))
