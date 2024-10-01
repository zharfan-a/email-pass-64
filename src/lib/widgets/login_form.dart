
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class LoginForm extends StatefulWidget {
	@override
	State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _formKey = GlobalKey<FormState>();
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();
	String? _errorMessage;

	@override
	Widget build(BuildContext context) {
		return BlocListener<AuthCubit, AuthState>(
			listener: (context, state) {
				if (state is AuthError) {
					setState(() {
						_errorMessage = state.message;
					});
				}
			},
			child: Form(
				key: _formKey,
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						children: [
							if (_errorMessage != null) 
								Text(
									_errorMessage!,
									style: TextStyle(color: Colors.red),
								),
							TextFormField(
								controller: _emailController,
								decoration: InputDecoration(labelText: 'Email'),
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Please enter a valid email';
									}
									final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
									if (!emailRegex.hasMatch(value)) {
										return 'Please enter a valid email';
									}
									return null;
								},
							),
							TextFormField(
								controller: _passwordController,
								decoration: InputDecoration(labelText: 'Password'),
								obscureText: true,
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Password is required';
									}
									return null;
								},
							),
							SizedBox(height: 20),
							ElevatedButton(
								onPressed: () {
									if (_formKey.currentState?.validate() ?? false) {
										BlocProvider.of<AuthCubit>(context).login(
											_emailController.text,
											_passwordController.text,
										);
									}
								},
								child: Text('Login'),
							),
						],
					),
				),
			),
		);
	}
}
