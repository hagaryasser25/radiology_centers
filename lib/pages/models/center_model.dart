import 'package:flutter/cupertino.dart';

class Centers {
  Centers({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? uid,
    String? imageUrl,
    String? address,
    String? workTime,
  }) {
    _id = id;
    _email = email;
    _name = name;
    _password = password;
    _phoneNumber = phoneNumber;
    _uid = uid;
    _imageUrl = imageUrl;
    _address = address;
    _workTime = workTime;
  }

  Centers.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _name = json['name'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _uid = json['uid'];
    _imageUrl = json['imageUrl'];
    _address = json['address'];
    _workTime = json['workTime'];
  }

  String? _id;
  String? _email;
  String? _name;
  String? _password;
  String? _phoneNumber;
  String? _uid;
  String? _imageUrl;
  String? _address;
  String? _workTime;

  String? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get password => _password;
  String? get phoneNumber => _phoneNumber;
  String? get uid => _uid;
  String? get imageUrl => _imageUrl;
  String? get address => _address;
  String? get workTime => _workTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['password'] = _password;
    map['phoneNumber'] = _phoneNumber;
    map['uid'] = _uid;
    map['imageUrl'] = _imageUrl;
    map['address'] = _address;
    map['workTime'] = _workTime;

    return map;
  }
}