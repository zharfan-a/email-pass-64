
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../widgets/login_form.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocListener<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is Authenticated) {
						Navigator.of(context).pushReplacement(
							MaterialPageRoute(builder: (context) => HomeScreen()),
						);
					}
				},
				child: BlocBuilder<AuthCubit, AuthState>(
					builder: (context, state) {
						if (state is AuthLoading) {
							return Center(child: CircularProgressIndicator());
						} else if (state is AuthError) {
							return Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									LoginForm(),
									SizedBox(height: 20),
									Text(
										state.message,
										style: TextStyle(color: Colors.red),
									),
								],
							);
						} else {
							return LoginForm();
						}
					},
				),
			),
		);
	}
}
