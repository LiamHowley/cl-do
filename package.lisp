(defpackage :cl-do
  (:use :cl)
  (:import-from :drakma
		:http-request)
  (:import-from :yason
		:parse
		:*parse-object-as*
		:encode-plist)
  (:export :list-all-droplets
	   :create-droplet))


(in-package :cl-do)

(defparameter auth-token
  (with-open-file (stream #P "~/do" :direction :input) 
    (let ((seq (make-array (file-length stream) :element-type 'character)))
      (read-sequence seq stream)
      seq)))
