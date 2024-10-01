
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/widgets/login_form.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
	group('LoginForm Widget Tests', () {
		// Test the presence of email and password fields and the login button
		testWidgets('should have email, password fields and login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: Scaffold(body: LoginForm())));

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.byType(ElevatedButton), findsOneWidget);
		});

		// Test input validation
		testWidgets('should show error if email is invalid', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: Scaffold(body: LoginForm())));
			await tester.enterText(find.byType(TextFormField).first, 'invalid email');
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			expect(find.text('Please enter a valid email'), findsOneWidget);
		});
		
		testWidgets('should show error if password is empty', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: Scaffold(body: LoginForm())));
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			expect(find.text('Password is required'), findsOneWidget);
		});
	});

	group('LoginForm Cubit Tests', () {
		late AuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'does not emit new states when email or password is invalid',
			build: () => mockAuthCubit,
			act: (cubit) {
				cubit.login('invalid email', 'password123');
				cubit.login('email@example.com', '');
			},
			expect: () => [],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, Authenticated] when email and password are valid',
			build: () => mockAuthCubit,
			act: (cubit) => cubit.login('email@example.com', 'password123'),
			expect: () => [AuthLoading(), Authenticated()],
		);

		testWidgets('should trigger cubit login method on form submit', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider.value(
							value: mockAuthCubit,
							child: LoginForm(),
						),
					),
				),
			);

			await tester.enterText(find.byType(TextFormField).first, 'email@example.com');
			await tester.enterText(find.byType(TextFormField).last, 'password123');
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => mockAuthCubit.login('email@example.com', 'password123')).called(1);
		});
	});
}
