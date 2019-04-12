// Auto-generated. Do not edit!

// (in-package robots_moviles_package.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class posicionRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.direccion = null;
    }
    else {
      if (initObj.hasOwnProperty('direccion')) {
        this.direccion = initObj.direccion
      }
      else {
        this.direccion = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type posicionRequest
    // Serialize message field [direccion]
    bufferOffset = _serializer.uint8(obj.direccion, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type posicionRequest
    let len;
    let data = new posicionRequest(null);
    // Deserialize message field [direccion]
    data.direccion = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'robots_moviles_package/posicionRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b5bf7493d22156dd1f31812556249ef8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 direccion
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new posicionRequest(null);
    if (msg.direccion !== undefined) {
      resolved.direccion = msg.direccion;
    }
    else {
      resolved.direccion = 0
    }

    return resolved;
    }
};

class posicionResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.resultado = null;
    }
    else {
      if (initObj.hasOwnProperty('resultado')) {
        this.resultado = initObj.resultado
      }
      else {
        this.resultado = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type posicionResponse
    // Serialize message field [resultado]
    bufferOffset = _serializer.uint8(obj.resultado, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type posicionResponse
    let len;
    let data = new posicionResponse(null);
    // Deserialize message field [resultado]
    data.resultado = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'robots_moviles_package/posicionResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5094b7919f0d704c7a17d30f84c3d596';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 resultado
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new posicionResponse(null);
    if (msg.resultado !== undefined) {
      resolved.resultado = msg.resultado;
    }
    else {
      resolved.resultado = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: posicionRequest,
  Response: posicionResponse,
  md5sum() { return '049d75b744ba6418566a32f18f43c69c'; },
  datatype() { return 'robots_moviles_package/posicion'; }
};
