import 'package:equatable/equatable.dart';

class SocialLinksState extends Equatable {
  final String error;
  final bool loading;

  const SocialLinksState({
    this.error = "",
    this.loading = false,
  });

  SocialLinksState copyWith({
    required String error,
    required bool loading,
  }) =>
      SocialLinksState(
        error: error,
        loading: loading,
      );

  @override
  List<Object> get props => [
        error,
        loading,
      ];
}
