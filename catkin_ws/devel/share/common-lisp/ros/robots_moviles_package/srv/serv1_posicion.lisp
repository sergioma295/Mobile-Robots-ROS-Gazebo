; Auto-generated. Do not edit!


(cl:in-package robots_moviles_package-srv)


;//! \htmlinclude serv1_posicion-request.msg.html

(cl:defclass <serv1_posicion-request> (roslisp-msg-protocol:ros-message)
  ((direccion
    :reader direccion
    :initarg :direccion
    :type cl:fixnum
    :initform 0))
)

(cl:defclass serv1_posicion-request (<serv1_posicion-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <serv1_posicion-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'serv1_posicion-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robots_moviles_package-srv:<serv1_posicion-request> is deprecated: use robots_moviles_package-srv:serv1_posicion-request instead.")))

(cl:ensure-generic-function 'direccion-val :lambda-list '(m))
(cl:defmethod direccion-val ((m <serv1_posicion-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robots_moviles_package-srv:direccion-val is deprecated.  Use robots_moviles_package-srv:direccion instead.")
  (direccion m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <serv1_posicion-request>) ostream)
  "Serializes a message object of type '<serv1_posicion-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direccion)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <serv1_posicion-request>) istream)
  "Deserializes a message object of type '<serv1_posicion-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direccion)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<serv1_posicion-request>)))
  "Returns string type for a service object of type '<serv1_posicion-request>"
  "robots_moviles_package/serv1_posicionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'serv1_posicion-request)))
  "Returns string type for a service object of type 'serv1_posicion-request"
  "robots_moviles_package/serv1_posicionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<serv1_posicion-request>)))
  "Returns md5sum for a message object of type '<serv1_posicion-request>"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'serv1_posicion-request)))
  "Returns md5sum for a message object of type 'serv1_posicion-request"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<serv1_posicion-request>)))
  "Returns full string definition for message of type '<serv1_posicion-request>"
  (cl:format cl:nil "uint8 direccion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'serv1_posicion-request)))
  "Returns full string definition for message of type 'serv1_posicion-request"
  (cl:format cl:nil "uint8 direccion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <serv1_posicion-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <serv1_posicion-request>))
  "Converts a ROS message object to a list"
  (cl:list 'serv1_posicion-request
    (cl:cons ':direccion (direccion msg))
))
;//! \htmlinclude serv1_posicion-response.msg.html

(cl:defclass <serv1_posicion-response> (roslisp-msg-protocol:ros-message)
  ((resultado
    :reader resultado
    :initarg :resultado
    :type cl:fixnum
    :initform 0))
)

(cl:defclass serv1_posicion-response (<serv1_posicion-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <serv1_posicion-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'serv1_posicion-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robots_moviles_package-srv:<serv1_posicion-response> is deprecated: use robots_moviles_package-srv:serv1_posicion-response instead.")))

(cl:ensure-generic-function 'resultado-val :lambda-list '(m))
(cl:defmethod resultado-val ((m <serv1_posicion-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robots_moviles_package-srv:resultado-val is deprecated.  Use robots_moviles_package-srv:resultado instead.")
  (resultado m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <serv1_posicion-response>) ostream)
  "Serializes a message object of type '<serv1_posicion-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'resultado)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <serv1_posicion-response>) istream)
  "Deserializes a message object of type '<serv1_posicion-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'resultado)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<serv1_posicion-response>)))
  "Returns string type for a service object of type '<serv1_posicion-response>"
  "robots_moviles_package/serv1_posicionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'serv1_posicion-response)))
  "Returns string type for a service object of type 'serv1_posicion-response"
  "robots_moviles_package/serv1_posicionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<serv1_posicion-response>)))
  "Returns md5sum for a message object of type '<serv1_posicion-response>"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'serv1_posicion-response)))
  "Returns md5sum for a message object of type 'serv1_posicion-response"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<serv1_posicion-response>)))
  "Returns full string definition for message of type '<serv1_posicion-response>"
  (cl:format cl:nil "uint8 resultado~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'serv1_posicion-response)))
  "Returns full string definition for message of type 'serv1_posicion-response"
  (cl:format cl:nil "uint8 resultado~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <serv1_posicion-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <serv1_posicion-response>))
  "Converts a ROS message object to a list"
  (cl:list 'serv1_posicion-response
    (cl:cons ':resultado (resultado msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'serv1_posicion)))
  'serv1_posicion-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'serv1_posicion)))
  'serv1_posicion-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'serv1_posicion)))
  "Returns string type for a service object of type '<serv1_posicion>"
  "robots_moviles_package/serv1_posicion")