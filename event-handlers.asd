
(asdf:defsystem #:event-handlers
  :description "Simple AOP style event handling mechanism (notifcation)"
  :author "VIP"
  :license "vip"
  ;; Depend on pg? I could split out pg-relations into another package depending on this
  ;; let's start like this
  :depends-on ()
  :serial t
  :components ((:file "package")
               (:file "event-handlers")))
