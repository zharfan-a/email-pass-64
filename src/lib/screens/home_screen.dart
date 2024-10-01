
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/home_content.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
				actions: [
					IconButton(
						icon: Icon(Icons.logout),
						onPressed: () {
							context.read<AuthCubit>().logout();
						},
					),
				],
			),
			body: BlocListener<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is AuthError) {
						ScaffoldMessenger.of(context).showSnackBar(
							SnackBar(content: Text(state.message)),
						);
					}
				},
				child: HomeContent(),
			),
		);
	}
}
