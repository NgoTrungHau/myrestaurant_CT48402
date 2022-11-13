import 'package:flutter/foundation.dart';

class Admin {
  final String? userId;
  final String role;

  Admin({
    this.userId,
    required this.role,
  });

  Admin copyWith({
    String? userId,
    String? role,
  }) {
    return Admin(
      userId: userId ?? this.userId,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
    };
  }

  static Admin fromJson(Map<String, dynamic> json) {
    return Admin(
      userId: json['userId'],
      role: json['role'],
    );
  }
}