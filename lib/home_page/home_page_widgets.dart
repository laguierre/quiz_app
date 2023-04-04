import 'package:flutter/material.dart';

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
                  text: user['points'],
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
                  text: user['rank'],
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
    return const Text('David\nCourtney',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 60));
  }
}

class QuizTopApp extends StatelessWidget {
  const QuizTopApp({Key? key}) : super(key: key);

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