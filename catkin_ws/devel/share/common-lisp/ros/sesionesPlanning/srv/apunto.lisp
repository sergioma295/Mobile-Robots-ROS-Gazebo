; Auto-generated. Do not edit!


(cl:in-package sesionesPlanning-srv)


;//! \htmlinclude apunto-request.msg.html

(cl:defclass <apunto-request> (roslisp-msg-protocol:ros-message)
  ((direccion
    :reader direccion
    :initarg :direccion
    :type cl:fixnum
    :initform 0))
)

(cl:defclass apunto-request (<apunto-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <apunto-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'apunto-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sesionesPlanning-srv:<apunto-request> is deprecated: use sesionesPlanning-srv:apunto-request instead.")))

(cl:ensure-generic-function 'direccion-val :lambda-list '(m))
(cl:defmethod direccion-val ((m <apunto-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sesionesPlanning-srv:direccion-val is deprecated.  Use sesionesPlanning-srv:direccion instead.")
  (direccion m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <apunto-request>) ostream)
  "Serializes a message object of type '<apunto-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direccion)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <apunto-request>) istream)
  "Deserializes a message object of type '<apunto-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direccion)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<apunto-request>)))
  "Returns string type for a service object of type '<apunto-request>"
  "sesionesPlanning/apuntoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'apunto-request)))
  "Returns string type for a service object of type 'apunto-request"
  "sesionesPlanning/apuntoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<apunto-request>)))
  "Returns md5sum for a message object of type '<apunto-request>"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'apunto-request)))
  "Returns md5sum for a message object of type 'apunto-request"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<apunto-request>)))
  "Returns full string definition for message of type '<apunto-request>"
  (cl:format cl:nil "uint8 direccion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'apunto-request)))
  "Returns full string definition for message of type 'apunto-request"
  (cl:format cl:nil "uint8 direccion~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <apunto-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <apunto-request>))
  "Converts a ROS message object to a list"
  (cl:list 'apunto-request
    (cl:cons ':direccion (direccion msg))
))
;//! \htmlinclude apunto-response.msg.html

(cl:defclass <apunto-response> (roslisp-msg-protocol:ros-message)
  ((resultado
    :reader resultado
    :initarg :resultado
    :type cl:fixnum
    :initform 0))
)

(cl:defclass apunto-response (<apunto-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <apunto-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'apunto-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sesionesPlanning-srv:<apunto-response> is deprecated: use sesionesPlanning-srv:apunto-response instead.")))

(cl:ensure-generic-function 'resultado-val :lambda-list '(m))
(cl:defmethod resultado-val ((m <apunto-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sesionesPlanning-srv:resultado-val is deprecated.  Use sesionesPlanning-srv:resultado instead.")
  (resultado m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <apunto-response>) ostream)
  "Serializes a message object of type '<apunto-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'resultado)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <apunto-response>) istream)
  "Deserializes a message object of type '<apunto-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'resultado)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<apunto-response>)))
  "Returns string type for a service object of type '<apunto-response>"
  "sesionesPlanning/apuntoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'apunto-response)))
  "Returns string type for a service object of type 'apunto-response"
  "sesionesPlanning/apuntoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<apunto-response>)))
  "Returns md5sum for a message object of type '<apunto-response>"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'apunto-response)))
  "Returns md5sum for a message object of type 'apunto-response"
  "049d75b744ba6418566a32f18f43c69c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<apunto-response>)))
  "Returns full string definition for message of type '<apunto-response>"
  (cl:format cl:nil "uint8 resultado~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'apunto-response)))
  "Returns full string definition for message of type 'apunto-response"
  (cl:format cl:nil "uint8 resultado~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <apunto-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <apunto-response>))
  "Converts a ROS message object to a list"
  (cl:list 'apunto-response
    (cl:cons ':resultado (resultado msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'apunto)))
  'apunto-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'apunto)))
  'apunto-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'apunto)))
  "Returns string type for a service object of type '<apunto>"
  "sesionesPlanning/apunto")