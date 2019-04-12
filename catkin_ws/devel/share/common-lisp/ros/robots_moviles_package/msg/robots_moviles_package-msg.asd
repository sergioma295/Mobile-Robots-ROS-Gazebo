
(cl:in-package :asdf)

(defsystem "robots_moviles_package-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "msg1_pose" :depends-on ("_package_msg1_pose"))
    (:file "_package_msg1_pose" :depends-on ("_package"))
  ))