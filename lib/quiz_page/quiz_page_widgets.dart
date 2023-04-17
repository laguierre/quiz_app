import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

class LottieBottom extends StatelessWidget {
  const LottieBottom({
    super.key,
    required this.clickedAnswerController,
    required this.height,
    required this.backgroundCirclesValue,
  });

  final AnimationController clickedAnswerController;
  final double height;
  final double backgroundCirclesValue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: -10 - clickedAnswerController.value * 10,
        left: 0,
        right: 0,
        height: height * 0.30 * backgroundCirclesValue +
            clickedAnswerController.value * 50,
        child: Lottie.asset(jsonLottieQuiz, frameRate: FrameRate(120)));
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.text,
    required this.opacity,
    required this.onTap,
    required this.animationOnClink,
    this.isPressed = false,
  });

  final String text;
  final double opacity;
  final VoidCallback onTap;
  final double animationOnClink;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heightIcon = 25;
    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: EdgeInsets.symmetric(
                    horizontal: kPadding * (1 - 0.7 * animationOnClink),
                    vertical: 10),
                padding: const EdgeInsets.all(kPadding),
                decoration: BoxDecoration(
                    color:
                    isPressed ? kColorClickQuizButton : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    border:
                    Border.all(width: 2, color: const Color(0xFF6882FA))),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: width -
                                2.5 * heightIcon -
                                kPadding * 2 * (1 - 0.7 * animationOnClink)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              text,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 28),
                            ),
                            Image.asset(
                              rightArrowIcon,
                              color: Colors.white,
                              fit: BoxFit.fitHeight,
                              height: heightIcon,
                            )
                          ],
                        ))))
          ],
        ),
      ),
    );
  }
}

