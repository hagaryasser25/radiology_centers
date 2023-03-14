import 'package:flutter/cupertino.dart';

class Results {
  Results({
    String? id,
    String? centerName,
    String? imageUrl,
    String? userName,
    String? result,
    String? date,
    String? userUid,
    String? reason,
  }) {
    _id = id;
    _centerName = centerName;
    _imageUrl = imageUrl;
    _userName = userName;
    _result = result;
    _date = date;
    _userUid = userUid;
    _reason = reason;
  }

  Results.fromJson(dynamic json) {
    _id = json['id'];
    _centerName = json['centerName'];
    _userName = json['userName'];
    _imageUrl = json['imageUrl'];
    _result = json['result'];
    _date = json['date'];
    _userUid = json['userUid'];
    _reason = json['reason'];
  }

  String? _id;
  String? _centerName;
  String? _userName;
  String? _imageUrl;
  String? _result;
  String? _date;
  String? _userUid;
  String? _reason;

  String? get id => _id;
  String? get centerName => _centerName;
  String? get userName => _userName;
  String? get imageUrl => _imageUrl;
  String? get result => _result;
  String? get date => _date;
  String? get userUid => _userUid;
  String? get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['centerName'] = _centerName;
    map['userName'] = _userName;
    map['imageUrl'] = _imageUrl;
    map['result'] = _result;
    map['date'] = _date;
    map['userUid'] = _userUid;
    map['reason'] = _reason;

    return map;
  }
}