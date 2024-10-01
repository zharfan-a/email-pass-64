
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';

class HomeContent extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final authCubit = context.read<AuthCubit>();
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				Text(
					'Home Screen',
					style: TextStyle(fontSize: 24),
				),
				SizedBox(height: 20),
				ElevatedButton(
					onPressed: () {
						authCubit.logout();
					},
					child: Text('Logout'),
				),
			],
		);
	}
}
