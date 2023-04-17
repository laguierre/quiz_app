import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/quick_play_page/quick_play_page.dart';
import 'home_page_widgets.dart';
import 'dart:math' as math;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> table = data;
    Map<String, String> user = userData;
    return Scaffold(
        backgroundColor: const Color(0xFF2B55C9),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("lib/assets/images/background.png"),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          const QuizTopApp(),
                          Name(user: '$user[ "name"]\n$user[ "surname"]'),
                          const SizedBox(height: 80),
                          LevelPointRank(user: user),
                          const SizedBox(height: 80),
                        ])),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Table(children: [
                      TableRow(children: [
                        TableCell(child: QuizCard(data: table[0])),
                        TableCell(child: QuizCard(data: table[1])),
                      ]),
                      TableRow(children: [
                        TableCell(child: QuizCard(data: table[2])),
                        TableCell(child: QuizCard(data: table[3])),
                      ])
                    ]))
              ],
            ),
          ),
        ));
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({Key? key, required this.data}) : super(key: key);
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * kQuizContainerFactor;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                reverseTransitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (_, __, ___) => QuickPlayPage(data: data)));
      },
      child: Hero(
        tag: data['title']!,
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, value) {
              return Transform.rotate(
                  angle: 2 * math.pi * animation.value,
                  child: CustomQuizCard(
                    height: height,
                    data: data,
                    animation: animation.value + 0.6,
                  ));
            },
          );
        },
        child: CustomQuizCard(height: height, data: data),
      ),
    );
  }
}
