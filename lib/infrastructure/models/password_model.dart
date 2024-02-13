import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:password_safe/domain/entities/id.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/config/key.dart' as key;

class PasswordModel {
  final String id;
  final String title;
  final String name;
  final String email;
  final String password;
  final String info;
  final int codePoint;
  final String? fontFamily;
  final String? fontPackage;
  final bool matchTextDirection;
  final bool favoriteTag;
  final bool mailTag;
  final bool networkTag;

  PasswordModel({
    required this.id,
    required this.title,
    required this.name,
    required this.email,
    required this.password,
    required this.info,
    required this.codePoint,
    required this.fontFamily,
    required this.fontPackage,
    required this.matchTextDirection,
    required this.favoriteTag,
    required this.mailTag,
    required this.networkTag,
  });

  static final encrypter = encrypt.Encrypter(encrypt.AES(
      encrypt.Key.fromUtf8(key.ENCRYPTION_KEY),
      mode: encrypt.AESMode.cbc));
  static final iv = encrypt.IV.fromUtf8(key.IV_KEY);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'email': email,
      'password': 'ENCRYPTED' + encrypter.encrypt(password, iv: iv).base16,
      'info': info,
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'matchTextDirection': matchTextDirection ? 1 : 0,
      'favoriteTag': favoriteTag ? 1 : 0,
      'mailTag': mailTag ? 1 : 0,
      'networkTag': networkTag ? 1 : 0,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    var pass;
    if (map['password'].toString().startsWith('ENCRYPTED')) {
      pass = encrypter.decrypt(
          encrypt.Encrypted.fromBase16(
              map['password'].toString().replaceAll('ENCRYPTED', '')),
          iv: iv);
    } else {
      pass = map['password'];
    }

    return PasswordModel(
      id: map['id'] as String,
      title: map['title'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: pass,
      info: map['info'] == null ? '' : map['info'] as String,
      codePoint: map['codePoint'] as int,
      fontFamily: map['fontFamily'],
      fontPackage: map['fontPackage'],
      matchTextDirection: map['matchTextDirection'] == 1 ? true : false,
      favoriteTag: map['favoriteTag'] == 1 ? true : false,
      mailTag: map['mailTag'] == 1 ? true : false,
      networkTag: map['networkTag'] == 1 ? true : false,
    );
  }

  PasswordModel copyWith({
    String? id,
    String? title,
    String? name,
    String? email,
    String? password,
    String? info,
    int? codePoint,
    String? fontFamily,
    String? fontPackage,
    bool? matchTextDirection,
    bool? favoriteTag,
    bool? mailTag,
    bool? networkTag,
  }) {
    return PasswordModel(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      info: info ?? this.info,
      codePoint: codePoint ?? this.codePoint,
      fontFamily: fontFamily ?? this.fontFamily,
      fontPackage: fontPackage ?? this.fontPackage,
      matchTextDirection: matchTextDirection ?? this.matchTextDirection,
      favoriteTag: favoriteTag ?? this.favoriteTag,
      mailTag: mailTag ?? this.mailTag,
      networkTag: networkTag ?? this.networkTag,
    );
  }

  Password toDomain() {
    return Password(
      id: UniqueID.fromUniqueString(id),
      title: title,
      name: name,
      email: email,
      password: password,
      info: info,
      icon: IconData(codePoint,
          fontFamily: fontFamily,
          fontPackage: fontPackage,
          matchTextDirection: matchTextDirection),
      favTag: favoriteTag,
      emailTag: mailTag,
      webTag: networkTag,
    );
  }

  factory PasswordModel.fromDomain(Password passwordItem) {
    return PasswordModel(
      id: passwordItem.id.value,
      title: passwordItem.title,
      name: passwordItem.name,
      email: passwordItem.email,
      password: passwordItem.password,
      info: passwordItem.info,
      codePoint: passwordItem.icon.codePoint,
      fontFamily: passwordItem.icon.fontFamily,
      fontPackage: passwordItem.icon.fontPackage,
      matchTextDirection: passwordItem.icon.matchTextDirection,
      favoriteTag: passwordItem.favTag,
      mailTag: passwordItem.emailTag,
      networkTag: passwordItem.webTag,
    );
  }
}
