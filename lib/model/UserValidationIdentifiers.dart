class UserValidationIdentifiers
{
  final String email;
  final String password;

  const UserValidationIdentifiers({
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson() {
    return
      {
      'email': email,
      'password': password,
    };
  }
}