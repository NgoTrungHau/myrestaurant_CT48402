class AuthToken {
  final String _token;
  final String _userId;
  // final bool _privilege;
  final DateTime _expiryDate;

  AuthToken({
    token,
    userId,
    // privilege,
    expiryDate,
  })  : _token = token,
        _userId = userId,
        // _privilege = privilege,
        _expiryDate = expiryDate;

  bool get isValid {
    return token != null;
  }

  String? get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  // bool get privilege {
  //   return _privilege;
  // }

  DateTime get expiryDate {
    return _expiryDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      'userId': _userId,
      // 'privilege': _privilege,
      'expiryDate': _expiryDate.toIso8601String(),
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['authToken'],
      userId: json['userId'],
      // privilege: json['privilege'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }
}
