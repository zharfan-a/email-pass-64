
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/screens/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Cubit Tests', () {
		late MockAuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<MockAuthCubit, AuthState>(
			'login emits [AuthLoading, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) {
				when(() => cubit.login('test@example.com', 'password')).thenAnswer((_) async {
					cubit.emit(AuthLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(Authenticated());
				});

				cubit.login('test@example.com', 'password');
			},
			expect: () => [AuthLoading(), Authenticated()],
		);

		blocTest<MockAuthCubit, AuthState>(
			'login emits [AuthLoading, Unauthenticated] when login fails',
			build: () => authCubit,
			act: (cubit) {
				when(() => cubit.login('test@example.com', 'wrongpassword')).thenAnswer((_) async {
					cubit.emit(AuthLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(Unauthenticated());
				});

				cubit.login('test@example.com', 'wrongpassword');
			},
			expect: () => [AuthLoading(), Unauthenticated()],
		);
	});

	group('LoginScreen Widget Tests', () {
		testWidgets('LoginScreen has a title and login form', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.text('Login'), findsOneWidget);
			expect(find.byType(LoginForm), findsOneWidget);
		});

		testWidgets('LoginScreen shows loading indicator when state is AuthLoading', (WidgetTester tester) async {
			final authCubit = MockAuthCubit();
			when(() => authCubit.state).thenReturn(AuthLoading());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.byType(CircularProgressIndicator), findsOneWidget);
		});

		testWidgets('LoginScreen navigates to HomeScreen when state is Authenticated', (WidgetTester tester) async {
			final authCubit = MockAuthCubit();
			when(() => authCubit.state).thenReturn(Authenticated());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: authCubit,
						child: LoginScreen(),
					),
				),
			);

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});
}
