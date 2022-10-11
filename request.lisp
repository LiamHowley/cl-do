(in-package :cl-do)


(defun uri (&key (base-uri *base-uri*) category identifier keys parameters)
  "Returns a formatted uri string. Params accepts a list of (key value) pairs."
  (let ((keys (when keys
		(typecase keys
		  (atom (list keys))
		  (cons keys)))))
    (format nil "~(~a~a~@[/~a~]~@[/~{~a~^/~}~]~)~@[?~{~{~a=~a~}~^&~}~]"
	    base-uri category identifier keys parameters)))


(defun request (fn &rest args)
  (let ((stream (funcall (apply fn args))))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    (yason:parse stream :object-as :plist
		 :object-key-fn #'(lambda (key)
				    (intern (substitute #\- #\_ (string-upcase key)) 'keyword)))))


(defun make-request (uri &key (content-type "application/json") method content headers (want-stream t))
  (let* ((auth `(("Authorization" . ,(auth-token))))
	 (headers (if headers (nconc auth headers) auth)))
    #'(lambda ()
	(http-request uri
		      :content-type content-type
		      :method method
		      :additional-headers headers
		      :content content
		      :want-stream want-stream))))


(defun get-request (uri &optional (method :get) headers)
  (make-request uri
		:method method
		:headers headers))

(defun post-request (uri &optional (method :post) data headers)
  (make-request uri
		:method method
		:content data
		:headers headers))

(defun put-request (uri data)
  (post-request uri :put data))

(defun delete-request (uri &optional headers)
  (get-request uri :delete headers))


(defun encode-plist (plist)
  (let ((yason:*symbol-key-encoder*
	 #'(lambda (symbol)
	     (substitute #\_ #\- (string-downcase (symbol-name symbol))))))
    (yason:encode-plist plist)))
