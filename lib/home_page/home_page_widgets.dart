import 'package:flutter/material.dart';

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