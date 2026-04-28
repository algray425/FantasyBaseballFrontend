class UserInfo
{
  final String userId;
  final String userName;

  const UserInfo({
    required this.userId,
    required this.userName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'userId': String userId,
      'userName': String userName,
      } =>
          UserInfo(
            userId: userId,
            userName: userName,
          ),
      _ => throw const FormatException("Could not read user!"),
    };
  }
}