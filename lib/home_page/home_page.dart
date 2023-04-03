import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/constants.dart';
import '../user_model/user_model.dart';
import 'home_page_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> table = data;
    return Scaffold(
      backgroundColor: const Color(0xFF2B55C9),
      body: FutureBuilder(
          future: loadJSONFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserQuiz user = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            const QuizTopApp(),
                            Name(user: '$user.name\n$user.surname'),
                            const SizedBox(height: 80),
                            LevelPointRank(user: user),
                            const SizedBox(height: 80),
                          ],
                        )),
                    Table(
                      children: [
                        TableRow(children: [
                          TableCell(child: QuizCard(data: table[0])),
                          TableCell(child: QuizCard(data: table[1])),
                        ]),
                        TableRow(children: [
                          TableCell(child: QuizCard(data: table[2])),
                          TableCell(child: QuizCard(data: table[3])),
                        ])
                      ],
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({Key? key, required this.data}) : super(key: key);

  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * kQuizContainerFactor;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      //width: 100,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data['subtitle']!,
            style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            height: 2,
            width: height * 0.2,
            color: Color(int.parse(data["color"]!)),
          ),
          Text(
            data['title']!,
            style: TextStyle(
              fontSize: 24,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            data["icon"]!,
            height: height * 0.30,
            fit: BoxFit.cover,
            color: Color(int.parse(data["color"]!)),
          ),
        ],
      ),
    );
  }
}

class LevelPointRank extends StatelessWidget {
  const LevelPointRank({Key? key, required this.user}) : super(key: key);
  final UserQuiz user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        const Spacer(),
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
        const Spacer(),
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

Future<UserQuiz> loadJSONFile() async {
  UserQuiz info;

  final String response =
      await rootBundle.loadString('lib/assets/json/user.json');
  info = UserQuiz.fromJson(json.decode(response));
  return info;
}
