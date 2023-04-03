import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/constants.dart';
import '../user_model/user_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B55C9),
      body: FutureBuilder(
          future: loadJSONFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserQuiz user = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const _TopApp(),
                  const Spacer(),
                  Name(user: '$user.name\n$user.surname'),
                  const SizedBox(height: 80),
                  LevelPointRank(user: user),
                  Spacer(),
                  QuizCard(),
                  const SizedBox(height: 50),

                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * kQuizContainerFactor;
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

Future<UserQuiz> loadJSONFile() async {
  UserQuiz info;

  final String response =
      await rootBundle.loadString('lib/assets/json/user.json');
  info = UserQuiz.fromJson(json.decode(response));
  return info;
}

class LevelPointRank extends StatelessWidget {
  const LevelPointRank({Key? key, required this.user}) : super(key: key);
  final UserQuiz user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Color(0xFFECD569), fontSize: 30),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Level\n', style: TextStyle(color: Color(0xFFECD569))),
              TextSpan(
                  text: user.level,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Color(0xFFECD569), fontSize: 30),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Points\n', style: TextStyle(color: Color(0xFFECD569))),
              TextSpan(
                  text: user.points,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Color(0xFFECD569), fontSize: 30),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Rank\n', style: TextStyle(color: Color(0xFFECD569))),
              TextSpan(
                  text: user.rank,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white)),
            ],
          ),
        )
      ],
    );
  }
}

class Name extends StatelessWidget {
  const Name({Key? key, required this.user}) : super(key: key);
  final String user;

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('David\nCourtney',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 60)));
  }
}

class _TopApp extends StatelessWidget {
  const _TopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.white,
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
