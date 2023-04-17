import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app/quiz_page/quiz_page.dart';

import '../constants.dart';


class InfCircle extends StatelessWidget {
  const InfCircle({
    super.key,
    required this.height,
    required this.backgroundCirclesValue,
  });

  final double height;
  final double backgroundCirclesValue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: -height * 0.2 * backgroundCirclesValue -
            height * 0.2 * (1 - backgroundCirclesValue),
        left: -height * 0.4 * backgroundCirclesValue -
            height * 0.4 * (1 - backgroundCirclesValue),
        right: 0,
        child: Container(
          height: height * 0.5 * backgroundCirclesValue,
          decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.7), shape: BoxShape.circle),
        ));
  }
}

class SupCircle extends StatelessWidget {
  const SupCircle({
    super.key,
    required this.height,
    required this.backgroundCirclesValue,
  });

  final double height;
  final double backgroundCirclesValue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: -height * 0.2 * backgroundCirclesValue -
            height * 0.2 * (1 - backgroundCirclesValue),
        right: -height * 0.4 * backgroundCirclesValue -
            height * 0.4 * (1 - backgroundCirclesValue),
        left: 0,
        child: Container(
          height: height * 0.75 * backgroundCirclesValue,
          decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.9), shape: BoxShape.circle),
        ));
  }
}

class Question extends StatelessWidget {
  const Question({
    super.key,
    required this.appearLinearBarValue, required this.text,
  });
  final String text;
  final double appearLinearBarValue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 160 + 30 * (1 - appearLinearBarValue),
      child: Opacity(
        opacity: (2 * appearLinearBarValue).clamp(0, 1),
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 32),
          ),
        ),
      ),
    );
  }
}

class TimeOutIndicator extends StatelessWidget {
  const TimeOutIndicator({
    super.key,
    required this.appearLinearBarValue,
    required this.linearBarAnimation,
    required this.widget,
  });

  final double appearLinearBarValue;
  final Animation<double> linearBarAnimation;
  final QuizPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 80 * appearLinearBarValue,
      child: LinearPercentIndicator(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          barRadius: const Radius.circular(5),
          lineHeight: 10.0,
          percent: 1 - linearBarAnimation.value,
          backgroundColor: Colors.grey.shade300,
          progressColor: Color(
            int.parse(widget.data["color"]!),
          )),
    );
  }
}
