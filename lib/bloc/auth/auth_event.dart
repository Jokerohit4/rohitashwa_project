
abstract class AuthEvent {}

class AuthObserve extends AuthEvent {}

class AuthNotify extends AuthEvent {
  final bool isAuthenticated;

  AuthNotify({this.isAuthenticated = false});
}