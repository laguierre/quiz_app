import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/constants.dart';

import 'quiz_page_widgets.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.data}) : super(key: key);

  final Map<String, String> data;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late AnimationController mainAnimationController;
  late AnimationController onClickController;
  late AnimationController clickedAnswerController;
  late Animation<double> appearLinearBarAnimation;
  late Animation<double> linearBarAnimation;
  late Animation<double> backgroundCirclesAnimation;
  late Animation<double> appearQuestionAnimation;
  late Animation<double> onClickAnimation;
  late Animation<double> clickedAnswerAnimation;

  double appearLinearBarValue = 0;
  double backgroundCirclesValue = 0;
  double appearQuestionValue = 0;
  double opacityAnswers = 0;
  double onClickValue = 0;
  double clickedAnswerValue = 0;
  bool isStartedPage = false;
  int quizPressButton = -1;

  @override
  void initState() {
    super.initState();

    ///Controllers
    mainAnimationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    onClickController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    clickedAnswerController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    ///Animation
    appearLinearBarAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: mainAnimationController,
      curve: const Interval(0.0, 0.1),
    ))
          ..addListener(() {
            setState(() {
              appearLinearBarValue = appearLinearBarAnimation.value;
            });
          });
    linearBarAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: mainAnimationController,
      curve: const Interval(0.1, 1),
    ))
          ..addListener(() {
            setState(() {});
          });
    backgroundCirclesAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: mainAnimationController,
      curve: const Interval(0.1, 0.3),
    ))
          ..addListener(() {
            setState(() {
              backgroundCirclesValue = backgroundCirclesAnimation.value;
            });
          });
    appearQuestionAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(
      parent: mainAnimationController,
      curve: const Interval(0.15, 0.4),
    ))
      ..addListener(() {
        setState(() {
          opacityAnswers = appearQuestionValue = appearQuestionAnimation.value;
        });
      });

    onClickAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: onClickController,
      curve: const Interval(0, 1),
    ))
      ..addListener(() {
        setState(() {
          if (onClickController.isCompleted) {
            clickedAnswerController.forward();
          }
          onClickValue = onClickAnimation.value;
        });
      });

    clickedAnswerAnimation =
        Tween<double>(begin: 0, end: 800).animate(CurvedAnimation(
      parent: clickedAnswerController,
      curve: Curves.linear,
    ))
          ..addListener(() {
            setState(() {
              clickedAnswerValue = clickedAnswerAnimation.value;
            });
          });

    ///Star main animation
    mainAnimationController.forward();
  }

  @override
  void dispose() {
    mainAnimationController.dispose();
    onClickController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double questionsRatio = 0.35;
    return Scaffold(
      backgroundColor: kColorPlayNow,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SupCircle(
              height: height, backgroundCirclesValue: backgroundCirclesValue),
          InfCircle(
              height: height, backgroundCirclesValue: backgroundCirclesValue),
          TimeOutIndicator(
              appearLinearBarValue: appearLinearBarValue,
              linearBarAnimation: linearBarAnimation,
              widget: widget),
          Question(
            appearLinearBarValue: appearLinearBarValue,
            text: 'On which fictional planet\nwas Superman born?',
          ),
          LottieBottom(
              clickedAnswerController: clickedAnswerController,
              height: height,
              backgroundCirclesValue: backgroundCirclesValue),
          Positioned(
              left: 0,
              right: width * (1 - appearQuestionValue) - clickedAnswerValue,
              top: height * questionsRatio +
                  height * (1 - questionsRatio) * (1 - appearQuestionValue),
              bottom: height * 0.15,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: quizAnswers.length,
                itemBuilder: (context, index) {
                  return AnswerButton(
                    text: quizAnswers[index],
                    opacity: opacityAnswers,
                    animationOnClink:
                        index == quizPressButton ? onClickValue : 0,
                    isPressed: index == quizPressButton ? true : false,
                    onTap: () {
                      if (onClickController.isCompleted) {
                        onClickController.reset();
                      }
                      onClickController.forward();
                      setState(() {
                        quizPressButton = index;
                      });
                    },
                  );
                },
              )),
          onClickValue == 1
              ? Positioned(
                  bottom: 0,
                  left: quizPressButton == 0? 0: 120,
                  right: quizPressButton == 0? 0: 120,
                  top: 0,
                  child: quizPressButton == 0
                      ? Lottie.asset(jsonLottieCorrect, repeat: false)
                      : SizedBox(child: Lottie.asset(jsonLottieWrong, repeat: false)),
                )
              : Container(),
          onClickValue == 1
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: height * 0.25,
                  child: Center(
                    child: Text(
                      quizAnswers[quizPressButton],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
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
                                2 * heightIcon -
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
