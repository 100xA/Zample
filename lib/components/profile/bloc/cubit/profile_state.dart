import 'package:equatable/equatable.dart';

import 'package:zample/components/profile/repo/profile.dart';

class ProfileState extends Equatable {
  final Profile profile;

  const ProfileState({
    this.profile,
  });

  ProfileState copyWith({
    Profile profile,
  }) =>
      ProfileState(profile: profile ?? this.profile);

  @override
  List<Object> get props => [profile];
}
