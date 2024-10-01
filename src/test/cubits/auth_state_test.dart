
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/auth_state.dart';

void main() {
	group('AuthState', () {
		test('supports value equality', () {
			expect(AuthInitial(), equals(AuthInitial()));
			expect(AuthLoading(), equals(AuthLoading()));
			expect(Authenticated(), equals(Authenticated()));
			expect(Unauthenticated(), equals(Unauthenticated()));
		});
		
		test('AuthInitial has correct props', () {
			expect(AuthInitial().props, []);
		});

		test('AuthLoading has correct props', () {
			expect(AuthLoading().props, []);
		});

		test('Authenticated has correct props', () {
			expect(Authenticated().props, []);
		});

		test('Unauthenticated has correct props', () {
			expect(Unauthenticated().props, []);
		});
	});
}
