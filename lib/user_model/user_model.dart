import 'dart:convert';

UserQuiz userQuizFromJson(String str) => UserQuiz.fromJson(json.decode(str));

class UserQuiz {
  UserQuiz({
    required this.name,
    required this.surname,
    required this.email,
    required this.level,
    required this.points,
    required this.rank,
  });

  String name;
  String surname;
  String email;
  String level;
  String points;
  String rank;

  factory UserQuiz.fromJson(Map<String, dynamic> json) => UserQuiz(
    name: json["name"],
    surname: json["surname"],
    email: json["email"],
    level: json["level"],
    points: json["Points"],
    rank: json["Rank"],
  );
}
