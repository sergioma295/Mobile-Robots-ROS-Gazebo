
(cl:in-package :asdf)

(defsystem "sesionesPlanning-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "apunto" :depends-on ("_package_apunto"))
    (:file "_package_apunto" :depends-on ("_package"))
  ))