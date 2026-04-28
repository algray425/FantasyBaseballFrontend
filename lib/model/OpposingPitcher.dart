class OpposingPitcher
{
  final String name;
  final double grade;

  const OpposingPitcher({
    required this.name,
    required this.grade,
  });

  factory OpposingPitcher.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'name': String name,
      'grade': double grade,
      } =>
          OpposingPitcher(
            name: name,
            grade: grade,
          ),
      _ => throw const FormatException("Could not read opposing pitcher!"),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grade': grade,
    };
  }
}