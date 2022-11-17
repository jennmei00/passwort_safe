import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:password_safe/domain/entities/id.dart';

class Password {
  final UniqueID id;
  final String title;
  final String name;
  final String email;
  final String password;
  final String link;
  final IconData icon;
  final List<Icon> tags;

  Password({
    required this.id,
    required this.title,
    required this.name,
    required this.email,
    required this.password,
    required this.link,
    required this.icon,
    required this.tags,
  });

  factory Password.empty() {
    return Password(
      id: UniqueID(),
      title: '',
      name: '',
      email: '',
      password: '',
      link: '',
      icon: CommunityMaterialIcons.image_plus,
      tags: [],
    );
  }

  Password copyWith({
    UniqueID? id,
    String? title,
    String? name,
    String? email,
    String? password,
    String? link,
    IconData? icon,
    List<Icon>? tags,
  }) {
    return Password(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      link: link ?? this.link,
      icon: icon ?? this.icon,
      tags: tags ?? this.tags,
    );
  }
}
