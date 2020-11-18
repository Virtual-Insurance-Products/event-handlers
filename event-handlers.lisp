(in-package :event)

(defclass event ()
  ((created :initform (get-universal-time) :reader event-created)))

(defclass handler () ())

(defmethod handler-type ((event event))
  ;; Override this method to manually specify the type of the handler class
  (let ((event-type (type-of event)))
    (intern (concatenate 'string
                         (symbol-name event-type)
                         "-HANDLER")
            (symbol-package event-type))))

(defmethod emit ((event event) &rest args)
  (declare (ignore args))
  (labels ((rec (class)
             (let ((subs (ccl:class-direct-subclasses class)))
               (if subs
                   (mapc #'rec subs)
                   ;; Ask leaf classes to handle the event
                   (handle event (make-instance class))))))
    (rec (find-class (handler-type event)))))


(defmethod emit ((e symbol) &rest args)
  (emit (apply #'make-instance (cons e args))))

(defgeneric handle (event handler))

;; EXAMPLE

;; convenience function for the type of event I have defined here
(defun created (object)
  (emit 'created :object object))

(defclass created (event)
  ((object :initarg :object :reader object)))

(defclass created-handler (handler)
  ())

(defmethod handle ((e created) (h created-handler))
  (object-created h (object e)))

;; don't do anything (by default) - override in subclasses
;; (this means subclasses don't have to be complete - they can handle only *some* types of object)
(defmethod object-created ((x created-handler) (object t))
  (declare (ignore x object)))

