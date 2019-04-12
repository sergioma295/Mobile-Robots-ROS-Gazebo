
(cl:in-package :asdf)

(defsystem "robots_moviles_package-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "serv1_posicion" :depends-on ("_package_serv1_posicion"))
    (:file "_package_serv1_posicion" :depends-on ("_package"))
  ))