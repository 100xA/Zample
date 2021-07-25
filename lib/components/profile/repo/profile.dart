import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  /// unique identifier for the user -> id of firebase document and firestore auth user
  final String uid;

  /// unique token of user device -> used for sending notifications

  /// url for location of profile picture on firestore storage
  final String avatarUrl;

  /// email of the user -> can be
  final String email;

  /// name of the university

  ///
  final String username;

  const Profile({
    required this.uid,
    required this.avatarUrl,
    required this.email,
    required this.username,
  });

  factory Profile.fromJson(Map<String, dynamic>? map) => Profile(
        uid: map!['uid'] as String,
        avatarUrl: map['avatarUrl'] as String,
        email: map['email'] as String,
        username: map['username'] as String,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "avatarUrl": avatarUrl,
        "email": email,
        "username": username,
      };

  Profile copyWith({
    String? uid,
    String? avatarUrl,
    String? email,
    String? username,
    int? ccid,
  }) =>
      Profile(
        uid: uid ?? this.uid,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        email: email ?? this.email,
        username: username ?? this.username,
      );

  @override
  List<Object> get props => [
        uid,
        avatarUrl,
        email,
        username,
      ];
}
