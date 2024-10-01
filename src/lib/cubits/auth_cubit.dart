
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		emit(AuthLoading());

		// Simulate a delay for the authentication process
		await Future.delayed(Duration(seconds: 1));

		// Mocked authentication logic
		if (email == 'test@example.com' && password == 'password') {
			emit(Authenticated());
		} else {
			emit(Unauthenticated());
		}
	}

	void logout() {
		emit(Unauthenticated());
	}
}
