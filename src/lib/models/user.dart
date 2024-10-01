import 'package:equatable/equatable.dart';

// The User class represents a user in the application.
// It implements the Equatable mixin to simplify equality comparisons.
class User extends Equatable {
  final String email;
  final String name;

  // Constructor to initialize the User with a name and email.
  const User({required this.email, required this.name});

  // Factory constructor to create a User instance from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json['email'], name: json['name']);
  }

  // Method to convert the User instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name};
  }

  // Override the == operator and hashCode using the Equatable mixin.
  @override
  List<Object?> get props => [email, name];
}
