import 'package:flutter/cupertino.dart';

class Booking {
  Booking({
    String? id,
    String? centerName,
    String? type,
    String? userName,
    String? userPhone,
    String? date,
    String? userUid,
  }) {
    _id = id;
    _centerName = centerName;
    _type = type;
    _userName = userName;
    _userPhone = userPhone;
    _date = date;
    _userUid = userUid;
  }

  Booking.fromJson(dynamic json) {
    _id = json['id'];
    _centerName = json['centerName'];
    _userName = json['userName'];
    _type = json['type'];
    _userPhone = json['userPhone'];
    _date = json['date'];
    _userUid = json['userUid'];
  }

  String? _id;
  String? _centerName;
  String? _userName;
  String? _type;
  String? _userPhone;
  String? _date;
  String? _userUid;

  String? get id => _id;
  String? get centerName => _centerName;
  String? get userName => _userName;
  String? get type => _type;
  String? get userPhone => _userPhone;
  String? get date => _date;
  String? get userUid => _userUid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['centerName'] = _centerName;
    map['userName'] = _userName;
    map['type'] = _type;
    map['userPhone'] = _userPhone;
    map['date'] = _date;
    map['userUid'] = _userUid;

    return map;
  }
}