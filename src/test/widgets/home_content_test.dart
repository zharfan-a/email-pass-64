
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:com.example.simple_app/widgets/home_content.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeContent Widget Tests', () {
		testWidgets('displays "Home Screen" text', (WidgetTester tester) async {
			// Build the HomeContent widget
			await tester.pumpWidget(MaterialApp(
				home: Scaffold(
					body: HomeContent(),
				),
			));
			
			// Verify the "Home Screen" text is displayed
			expect(find.text('Home Screen'), findsOneWidget);
		});

		testWidgets('displays a logout button', (WidgetTester tester) async {
			// Build the HomeContent widget
			await tester.pumpWidget(MaterialApp(
				home: Scaffold(
					body: HomeContent(),
				),
			));

			// Verify the logout button is displayed
			expect(find.widgetWithText(ElevatedButton, 'Logout'), findsOneWidget);
		});
	});

	group('HomeContent Cubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [isA<Unauthenticated>()],
		);
	});
}
