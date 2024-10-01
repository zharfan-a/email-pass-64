
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Mock AuthCubit for testing
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders MyApp', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(MaterialApp), findsOneWidget);
		});

		testWidgets('initial route is LoginScreen', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});

	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits AuthLoading and then Authenticated on login',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthLoading(), Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits AuthLoading and then Unauthenticated on logout',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [AuthLoading(), Unauthenticated()],
		);
	});
}
