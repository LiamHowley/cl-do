(defpackage :cl-do
  (:use :cl)
  (:import-from :drakma
		:http-request)
  (:import-from :puri
		:uri)
  (:import-from :yason
		:parse
		:*parse-object-as*
		:*parse-json-arrays-as-vectors*
		:encode-plist)
  (:export :list-all-droplets
	   :list-all-droplets-by-tag
	   :create-droplet
	   :create-multiple-droplets))


(in-package :cl-do)

(defparameter *auth-token*
  (with-open-file (stream #P "~/do" :direction :input) 
    (let ((seq (make-array (file-length stream) :element-type 'character)))
      (read-sequence seq stream)
      seq)))

(defun parse-response (response)
  (let* ((length (array-total-size response))
	 (json-string (make-array length :element-type 'character)))
    (loop for count from 0 below length
       for char = (code-char (aref response count))
       when char
       do (setf (char json-string count) char))
    (yason:parse json-string)))
       
(defun get-request (url)
  (http-request "https://api.digitalocean.com/v2/droplets"
		:content-type "application/json"
		:additional-headers `(("Authorization" . ,(concatenate 'string "Bearer " *auth-token*)))))

(defun post-request (url data)
  (http-request "https://api.digitalocean.com/v2/droplets"
		:content-type "application/json"
		:method "post"
		:content data
		:additional-headers `(("Authorization" . ,(concatenate 'string "Bearer " *auth-token*)))))
