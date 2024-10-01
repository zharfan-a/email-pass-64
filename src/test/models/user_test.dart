
// test/models/user_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/models/user.dart';

void main() {
	group('User Model', () {
		test('should create a User instance with given name and email', () {
			final user = User(name: 'John Doe', email: 'john.doe@example.com');

			expect(user.name, 'John Doe');
			expect(user.email, 'john.doe@example.com');
		});

		test('should correctly serialize User to JSON', () {
			final user = User(name: 'John Doe', email: 'john.doe@example.com');
			final userJson = user.toJson();

			expect(userJson, {
				'name': 'John Doe',
				'email': 'john.doe@example.com',
			});
		});

		test('should correctly deserialize User from JSON', () {
			final userJson = {
				'name': 'John Doe',
				'email': 'john.doe@example.com',
			};
			final user = User.fromJson(userJson);

			expect(user.name, 'John Doe');
			expect(user.email, 'john.doe@example.com');
		});

		test('should have correct equality based on properties', () {
			final user1 = User(name: 'John Doe', email: 'john.doe@example.com');
			final user2 = User(name: 'John Doe', email: 'john.doe@example.com');
			final user3 = User(name: 'Jane Doe', email: 'jane.doe@example.com');

			expect(user1, equals(user2));
			expect(user1, isNot(equals(user3)));
		});
	});
}
