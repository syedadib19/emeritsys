class User {
  final int id;
  final String name;
  final String college_number;

  User({required this.id, required this.name, required this.college_number});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id']),
      name: json['name'],
      college_number: json['college_number'],
    );
  }
}