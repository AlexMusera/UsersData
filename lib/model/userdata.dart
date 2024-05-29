class UserData {
  final String id;
  final String name;
  final String email;
  final String occupation;
  final String bio;

  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.occupation,
      required this.bio});

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    return UserData(
        id: parsedJson['_id'],
        name: parsedJson['name'],
        email: parsedJson['email'],
        occupation: parsedJson['occupation'],
        bio: parsedJson['bio']);
  }
}
