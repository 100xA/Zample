import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Profile extends Equatable {
  /// unique identifier for the user -> id of firebase document and firestore auth user
  final String uid;

  /// url for location of profile picture on firestore storage
  final String avatarUrl;

  /// email of the user -> can be
  final String email;

  /// username of the user -> is given by the email
  final String username;

  /// description of the user -> either user-changed or "Meine Beschreibung" as default
  final String description;

  const Profile({
    @required this.uid,
    @required this.avatarUrl,
    @required this.email,
    @required this.username,
    @required this.description,
  });

  factory Profile.fromJson(Map<String, dynamic> map) => Profile(
        uid: map['uid'] as String,
        avatarUrl: map['avatarUrl'] as String,
        email: map['email'] as String,
        username: map['username'] as String,
        description: map['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "avatarUrl": avatarUrl,
        "email": email,
        "username": username,
        "description": description
      };

  Profile copyWith({
    String uid,
    String avatarUrl,
    String email,
    String username,
    String description,
  }) =>
      Profile(
        uid: uid ?? this.uid,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        email: email ?? this.email,
        username: username ?? this.username,
        description: description ?? this.description,
      );

  @override
  List<Object> get props => [uid, avatarUrl, email, username, description];
}
