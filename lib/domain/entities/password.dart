import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:password_safe/domain/entities/id.dart';

class Password {
  final UniqueID id;
  final String title;
  final String name;
  final String email;
  final String password;
  final String info;
  final IconData icon;
  final bool favTag;
  final bool emailTag;
  final bool webTag;

  Password({
    required this.id,
    required this.title,
    required this.name,
    required this.email,
    required this.password,
    required this.icon,
    required this.info,
    required this.favTag,
    required this.emailTag,
    required this.webTag,
  });

  factory Password.empty() {
    return Password(
      id: UniqueID(),
      title: '',
      name: '',
      email: '',
      password: '',
      info: '',
      icon: CommunityMaterialIcons.image_plus,
      favTag: false,
      emailTag: false,
      webTag: false,
    );
  }

  Password copyWith({
    UniqueID? id,
    String? title,
    String? name,
    String? email,
    String? password,
    String? info,
    IconData? icon,
    bool? favTag,
    bool? emailTag,
    bool? webTag,
  }) {
    return Password(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      info: info ?? this.info,
      icon: icon ?? this.icon,
      favTag: favTag ?? this.favTag,
      emailTag: emailTag ?? this.emailTag,
      webTag: webTag ?? this.webTag,
    );
  }
}
