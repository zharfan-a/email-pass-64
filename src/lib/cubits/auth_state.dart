
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
	const AuthState();

	@override
	List<Object> get props => [];
}

class AuthInitial extends AuthState {
	const AuthInitial();
}

class AuthLoading extends AuthState {
	const AuthLoading();
}

class Authenticated extends AuthState {
	const Authenticated();
}

class Unauthenticated extends AuthState {
	const Unauthenticated();
}

class AuthError extends AuthState {
	final String message;

	const AuthError(this.message);

	@override
	List<Object> get props => [message];
}
