(in-package :cl-do)

(defun list-images (&optional parameters)
  "Parameters accepts a list of (key value) pairs."
  (request #'get-request (uri :category "images" :parameters parameters)))

(defun create-custom-image (&rest image-data &key name url region distribution description tags)
  "Name, url and region are required."
  (declare (ignore name url region distribution description tags))
  (request #'post-request (uri :category "images") (encode-plist image-data)))

(defun retrieve-image (image-id)
  "Retrieves an existing image. Public images can be identified by image id or slug.
Private images must be identified by image id."
  (request #'get-request (uri :category "images" :identifier image-id)))

(defun update-image (image-id &rest params &key name distribution description)
  "Updates an existing image. The name of a custom image's distribution. Currently, the valid values are 'Arch Linux', 'CentOS', 'CoreOS', 'Debian', 'Fedora', 'Fedora Atomic', 'FreeBSD', 'Gentoo', 'openSUSE', 'RancherOS', 'Ubuntu', and 'Unknown'. Any other value will be accepted but ignored, and 'Unknown' will be used in its place."
  (request #'put-request (uri :category "images" :identifier image-id) (encode-plist params)))

(defun delete-image (image-id)
  "Deletes an existing image."
  (request #'delete-request (uri :category "images" :identifier image-id)))
