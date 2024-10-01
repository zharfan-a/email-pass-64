
import 'package:equatable/equatable.dart';

// The User class represents a user in the application.
// It implements the Equatable mixin to simplify equality comparisons.
class User extends Equatable {
	final String name;
	final String email;

	// Constructor to initialize the User with a name and email.
	const User({required this.name, required this.email});

	// Factory constructor to create a User instance from a JSON map.
	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			name: json['name'],
			email: json['email']
		);
	}

	// Method to convert the User instance to a JSON map.
	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'email': email
		};
	}

	// Override the == operator and hashCode using the Equatable mixin.
	@override
	List<Object?> get props => [name, email];
}
