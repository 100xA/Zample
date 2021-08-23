import 'package:equatable/equatable.dart';

import 'package:zample/components/profile/repo/profile.dart';

class ProfileState extends Equatable {
  final Profile profile;
  final bool loading;

  const ProfileState({
    this.profile,
    this.loading,
  });

  ProfileState copyWith({
    Profile profile,
    bool loading,
  }) =>
      ProfileState(
          profile: profile ?? this.profile, loading: loading ?? this.loading);

  @override
  List<Object> get props => [profile, loading];
}
