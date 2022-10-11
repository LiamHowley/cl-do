(in-package :cl-do)

(defun view-account ()
  "View information about account"
  (request #'get-request (uri :category "account")))
  
(defun list-keys (&optional parameters)
  "Lists all keys. Can be filtered by specifying parameters in (key value) pairs: 
e.g. (\"page\" 1), (\"per_page\" 20)."
  (request #'get-request (uri :category "account/keys" :parameters parameters)))

(defun create-key (&rest params &key name public-key)
  "Name, region, size, and key are required. Defaults are false, 
or empty arrays in the case of ssh-keys and tags."
  (declare (ignore name public-key))
  (request #'post-request (uri :category "account/keys") (encode-plist params)))

(defun retrieve-key (key-id)
  "Retrieves an existing key."
  (request #'get-request (uri :category "account/keys" :identifier key-id)))

(defun update-key (key-id &rest params &key name)
  "Updates an existing key." 
  (request #'put-request (uri :category "account/keys" :identifier key-id) (encode-plist params)))

(defun delete-key (key-id)
  "Deletes an existing key."
  (request #'delete-request (uri :category "account/keys" :identifier key-id)))
