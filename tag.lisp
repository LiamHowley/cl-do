(in-package :cl-do)

(defun list-tags (&optional parameters)
  "Parameters accepts a list of (key value) pairs."
  (request #'get-request (uri :category "tags" :parameters parameters)))

(defun create-tag (&rest tag-data &key name)
  "Name is required."
  (declare (ignore name))
  (request #'post-request (uri :category "tags") (encode-plist tag-data)))

(defun retrieve-tag (tag-name)
  "Retrieves an existing tag. Tags are identified by their name. Note: names are case sensitive" 
  (request #'get-request (uri :category "tags" :identifier tag-name)))

(defun delete-tag (tag-name)
  "Deletes an existing tag."
  (request #'delete-request (uri :category "tags" :identifier tag-name)))

(defun tag-resource (tag-name resources)
  "Tags a resource"
  (request #'post-request (uri :category "tags" :identifier `(,tag-name "resources")) (encode-plist resources))
