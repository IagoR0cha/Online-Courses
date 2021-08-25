// import './CardModel.dart';

class User {
  final String? id;
  final String email;
  final String? name;
  final String? cpf;
  final String? picture;
  final String? nivelSchool;
  final String token;
  final DateTime expirationDate;

  const User({
    this.id,
    required this.email,
    this.name,
    this.cpf,
    this.picture,
    this.nivelSchool,
    required this.token,
    required this.expirationDate,
  });
}

class DataUser {
  final String email;
  final String name;
  final String cpf;
  final String nivelSchool;

  const DataUser({
    required this.email,
    required this.name,
    required this.cpf,
    required this.nivelSchool
  });
}