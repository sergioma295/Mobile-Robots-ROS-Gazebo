; Auto-generated. Do not edit!


(cl:in-package robots_moviles_package-srv)


;//! \htmlinclude posicion-request.msg.html

(cl:defclass <posicion-request> (roslisp-msg-protocol:ros-message)
  ((direccion
    :reader direccion
    :initarg :direccion
    :type cl:fixnum
    :initform 0))
)

(cl:defclass posicion-request (<posicion-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <posicion-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'posicion-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robots_moviles_package-srv:<posicion-request> is deprecated: use robots_moviles_package-srv:posicion-request instead.")))

(cl:ensure-generic-function 'direccion-val :lambda-list '(m))
(cl:defmethod direccion-val ((m <posicion-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robots_moviles_package-srv:direccion-val is deprecated.  Use robots_moviles_package-srv:direccion instead.")
  (direccion m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <posicion-request>) ostream)
  "Serializes a message object of type '<posicion-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direccion)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <posicion-request>) istream)
  "Deserializes a message object of type '<posicion-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direccion)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<posicion-request>)))
  "Returns string type for a service object of type '<posicion-request>"
  "robots_moviles_package/posicionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'posicion-request)))
  "Returns string type for a service object of type 'posicion-request"
  "robots_moviles_package/posicionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<posicion-request>)))
  "Returns md5sum for a message object of type '<posicion-request>"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'posicion-request)))
  "Returns md5sum for a message object of type 'posicion-request"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<posicion-request>)))
  "Returns full string definition for message of type '<posicion-request>"
  (cl:format cl:nil "uint8 direccion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'posicion-request)))
  "Returns full string definition for message of type 'posicion-request"
  (cl:format cl:nil "uint8 direccion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <posicion-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <posicion-request>))
  "Converts a ROS message object to a list"
  (cl:list 'posicion-request
    (cl:cons ':direccion (direccion msg))
))
;//! \htmlinclude posicion-response.msg.html

(cl:defclass <posicion-response> (roslisp-msg-protocol:ros-message)
  ((resultado
    :reader resultado
    :initarg :resultado
    :type cl:fixnum
    :initform 0))
)

(cl:defclass posicion-response (<posicion-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <posicion-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'posicion-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robots_moviles_package-srv:<posicion-response> is deprecated: use robots_moviles_package-srv:posicion-response instead.")))

(cl:ensure-generic-function 'resultado-val :lambda-list '(m))
(cl:defmethod resultado-val ((m <posicion-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robots_moviles_package-srv:resultado-val is deprecated.  Use robots_moviles_package-srv:resultado instead.")
  (resultado m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <posicion-response>) ostream)
  "Serializes a message object of type '<posicion-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'resultado)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <posicion-response>) istream)
  "Deserializes a message object of type '<posicion-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'resultado)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<posicion-response>)))
  "Returns string type for a service object of type '<posicion-response>"
  "robots_moviles_package/posicionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'posicion-response)))
  "Returns string type for a service object of type 'posicion-response"
  "robots_moviles_package/posicionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<posicion-response>)))
  "Returns md5sum for a message object of type '<posicion-response>"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'posicion-response)))
  "Returns md5sum for a message object of type 'posicion-response"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<posicion-response>)))
  "Returns full string definition for message of type '<posicion-response>"
  (cl:format cl:nil "uint8 resultado~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'posicion-response)))
  "Returns full string definition for message of type 'posicion-response"
  (cl:format cl:nil "uint8 resultado~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <posicion-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <posicion-response>))
  "Converts a ROS message object to a list"
  (cl:list 'posicion-response
    (cl:cons ':resultado (resultado msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'posicion)))
  'posicion-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'posicion)))
  'posicion-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'posicion)))
  "Returns string type for a service object of type '<posicion>"
  "robots_moviles_package/posicion")