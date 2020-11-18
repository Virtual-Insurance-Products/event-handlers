
(in-package :cl-user)

(defpackage :event
  (:use #:cl)
  (:export

   #:event
   #:handler
   
   #:handler-type

   #:emit ; general emit (inc. custom events)
   #:handle
   
   #:created
   #:object ; accessor for object-created event
   #:created-handler
   #:object-created ; specific method for this event

   ))
