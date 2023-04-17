import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class LevelPointRank extends StatelessWidget {
  const LevelPointRank({Key? key, required this.user}) : super(key: key);

  final Map<String, String> user;

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
                  text: user['level'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white)),
            ],
          )),
          const Spacer(),
          RichText(
              text: TextSpan(
            style: const TextStyle(color: Color(0xFFECD569), fontSize: 30),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Points\n', style: TextStyle(color: Color(0xFFECD569))),
              TextSpan(
                  text: user['points'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white)),
            ],
          )),
          const Spacer(),
          RichText(
              text: TextSpan(
            style: const TextStyle(color: Color(0xFFECD569), fontSize: 30),
            children: <TextSpan>[
              const TextSpan(
                  text: 'Rank\n', style: TextStyle(color: Color(0xFFECD569))),
              TextSpan(
                  text: user['rank'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white)),
            ],
          ))
        ]);
  }
}

class Name extends StatelessWidget {
  const Name({Key? key, required this.user}) : super(key: key);
  final String user;

  @override
  Widget build(BuildContext context) {
    return Text('${userData['name']}\n${userData['surname']}',
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 60));
  }
}

class QuizTopApp extends StatelessWidget {
  const QuizTopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Spacer(),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
        color: Colors.white,
      ),
      const SizedBox(width: 10),
    ]);
  }
}

class CustomQuizCard extends StatelessWidget {
  const CustomQuizCard({
    super.key,
    required this.height,
    required this.data,
    this.animation = 0,
  });

  final double height;
  final Map<String, String> data;
  final double animation;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Opacity(
            opacity: (1 - animation).clamp(0, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data['subtitle']!,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  height: 2,
                  width: height * 0.2,
                  color: Color(int.parse(data["color"]!)),
                ),
                Text(
                  data['title']!,
                  style: TextStyle(
                    fontSize: 24 * height * 0.0052,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  data["icon"]!,
                  height: height * 0.30,
                  fit: BoxFit.fitHeight,
                  color: Color(int.parse(data["color"]!)),
                )
              ],
            )));
  }
}
