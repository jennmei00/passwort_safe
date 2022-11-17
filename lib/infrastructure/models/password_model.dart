import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:password_safe/domain/entities/id.dart';
import 'package:password_safe/domain/entities/password.dart';

class PasswordModel {
  final String id;
  final String title;
  final String name;
  final String email;
  final String password;
  final String link;
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
    required this.link,
    required this.codePoint,
    required this.fontFamily,
    required this.fontPackage,
    required this.matchTextDirection,
    required this.favoriteTag,
    required this.mailTag,
    required this.networkTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'email': email,
      'password': password,
      'link': link,
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'matchTextDirection': matchTextDirection,
      'favoriteTag': favoriteTag,
      'mailTag': mailTag,
      'networkTag': networkTag,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      id: '',
      title: map['title'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      link: map['link'] as String,
      codePoint: map['codePoint'] as int,
      fontFamily: map['fontFamily'] as String,
      fontPackage: map['fontPackage'] as String,
      matchTextDirection: map['matchTextDirection'] as bool,
      favoriteTag: map['favoriteTag'] as bool,
      mailTag: map['mailTag'] as bool,
      networkTag: map['networkTag'] as bool,
    );
  }

  PasswordModel copyWith({
    String? id,
    String? title,
    String? name,
    String? email,
    String? password,
    String? link,
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
      link: link ?? this.link,
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
      id: UniqueID(),
      title: title,
      name: name,
      email: email,
      password: password,
      link: link,
      icon: IconData(codePoint,
          fontFamily: fontFamily,
          fontPackage: fontPackage,
          matchTextDirection: matchTextDirection),
      tags: getIconsFromTags(),
    );
  }

  factory PasswordModel.fromDomain(Password passwordItem) {
    bool fav = passwordItem.tags.contains(Icon(CommunityMaterialIcons.heart))
        ? true
        : false;
    bool mail = passwordItem.tags.contains(Icon(CommunityMaterialIcons.mail))
        ? true
        : false;
    bool net = passwordItem.tags.contains(Icon(CommunityMaterialIcons.web))
        ? true
        : false;

    return PasswordModel(
      id: passwordItem.id.value,
      title: passwordItem.title,
      name: passwordItem.name,
      email: passwordItem.email,
      password: passwordItem.password,
      link: passwordItem.link,
      codePoint: passwordItem.icon.codePoint,
      fontFamily: passwordItem.icon.fontFamily,
      fontPackage: passwordItem.icon.fontPackage,
      matchTextDirection: passwordItem.icon.matchTextDirection,
      favoriteTag: fav,
      mailTag: mail,
      networkTag: net,
    );
  }

  List<Icon> getIconsFromTags() {
    List<Icon> tags = [];

    if (favoriteTag) {
      tags.add(Icon(CommunityMaterialIcons.heart));
    }

    if (mailTag) {
      tags.add(Icon(CommunityMaterialIcons.mail));
    }

    if (networkTag) {
      tags.add(Icon(CommunityMaterialIcons.web));
    }

    return tags;
  }
}
