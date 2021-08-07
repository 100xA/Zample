import 'package:equatable/equatable.dart';

class SocialLinksState extends Equatable {
  final String error;
  final bool loading;
  final bool authenticated;

  const SocialLinksState({
    this.error = "",
    this.loading = false,
    this.authenticated = false,
  });

  SocialLinksState copyWith({String error, bool loading, bool authenticated}) =>
      SocialLinksState(
        error: error,
        loading: loading,
        authenticated: authenticated,
      );

  @override
  List<Object> get props => [error, loading, authenticated];
}
