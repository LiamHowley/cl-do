(in-package :cl-do)

(defun list-vpcs (&optional parameters)
  "Lists all vpcs. Can be filtered by specifying parameters in (key value) pairs: 
e.g. (\"page\" 1), (\"per_page\" 20)."
  (request #'get-request (uri :category "vpcs" :parameters parameters)))

(defun create-vpc (&rest params &key name description region ip-range)
  "Name and region are required. Defaults are false."
  (declare (ignore name description region))
  (request #'post-request (uri :category "vpcs") (encode-plist params)))

(defun retrieve-vpc (vpc-id)
  "Retrieves an existing vpc."
  (request #'get-request (uri :category "vpcs" :identifier vpc-id)))

(defun retrieve-vpc-members (vpc-id &optional parameters)
  "Retrieves a list of resources that are members of a vpc. Use parameters to filter: e.g. (\"resource_type\" \"droplet\")."
  (request #'get-request (uri :category "vpcs" :identifier `(,vpc-id "members") :parameters parameters)))

(defun update-vpc (vpc-id &rest params &key name description default)
  "Updates an existing vpc. Name is required. Defaults is a boolean." 
  (declare (ignore name description default))
  (request #'put-request (uri :category "vpcs" :identifier vpc-id) (encode-plist params)))

(defun partial-update-vpc (vpc-id &rest params &key name description default)
  "Updates an existing vpc. Name is required. Defaults is a boolean." 
  (declare (ignore name description default))
  (request #'patch-request (uri :category "vpcs" :identifier vpc-id) (encode-plist params)))

(defun delete-vpc (vpc-id)
  "Deletes an existing vpc."
  (request #'delete-request (uri :category "vpcs" :identifier vpc-id)))
