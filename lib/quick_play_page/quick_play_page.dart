import 'package:flutter/material.dart';
import '../quiz_page/quiz_page.dart';
import 'quick_play_widgets.dart';

class QuickPlayPage extends StatefulWidget {
  const QuickPlayPage({Key? key, required this.data}) : super(key: key);
  final Map<String, String> data;

  @override
  State<QuickPlayPage> createState() => _QuickPlayPageState();
}

class _QuickPlayPageState extends State<QuickPlayPage>
    with TickerProviderStateMixin {
  late AnimationController tweenAnimationController;
  late AnimationController rippleAnimationController;
  late AnimationController cascadeControllerAnimation;
  late AnimationController playNowControllerAnimation;
  late Animation<double> animationTween;
  late Animation<double> animationRipple;
  late Animation<double> animationButton;
  late Animation<double> animationPostButton;
  late Animation<double> animationPlayNowClick;
  late bool isButtonCompleted = false;
  double moveLeftCircles = 0;
  double animationPlayNowValue = 1, animationTweenValue = 0;
  bool isPlayNowAnimationFinished = false;

  @override
  void initState() {
    super.initState();
    tweenAnimationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    rippleAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    cascadeControllerAnimation = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    playNowControllerAnimation = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    animationTween = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: tweenAnimationController,
      curve: Curves.linear,
    ))
      ..addListener(() {
        if (tweenAnimationController.isCompleted) {
          rippleAnimationController.repeat();
          cascadeControllerAnimation.forward();
        }
        animationTweenValue = tweenAnimationController.value;
        setState(() {});
      });
    animationRipple =
        Tween<double>(begin: 0.4, end: 1.0).animate(rippleAnimationController)
          ..addListener(() {
            setState(() {});
          });

    ///Button Animation
    animationButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: cascadeControllerAnimation, curve: const Interval(0.0, 0.8)),
    )..addListener(() {
        setState(() {});
      });
    animationPostButton = Tween<double>(begin: 0.0, end: 90).animate(
      CurvedAnimation(
          parent: cascadeControllerAnimation, curve: const Interval(0.165, 1)),
    )..addListener(() {
        if (animationPostButton.isCompleted) {
          isButtonCompleted = true;
        }
        setState(() {});
      });

    ///Animation when "Play Now" is clicked
    animationPlayNowClick = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
          parent: playNowControllerAnimation, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {
          if (animationPlayNowClick.isCompleted) {
            Navigator.pushReplacement(
                context,
                 MaterialPageRoute(
                    builder: (BuildContext context) => QuizPage(data: widget.data)));
          }
          moveLeftCircles = 50 * (1 - animationPlayNowClick.value);
          animationPlayNowValue = animationPlayNowClick.value;
        });
      });

    rippleAnimationController.repeat();
    tweenAnimationController.forward();
  }

  @override
  void dispose() {
    tweenAnimationController.dispose();
    rippleAnimationController.dispose();
    cascadeControllerAnimation.dispose();
    playNowControllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double kSizeContainerLogo = height * 0.25;
    double heightButton = 75.0;
    double topContainerCircles = height * 0.23 + kSizeContainerLogo + 50;
    double bottomContainerCircles = heightButton + 60 + 30;
    //print('${topContainerCircles} - ${bottomContainerCircles}');
    return Scaffold(
        backgroundColor: const Color(0xFF2B55C9),
        body: Hero(
            tag: widget.data['title']!,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BackButtonQuiz(widget: widget),
                  TitleQuiz(
                      animationTween:
                          animationTweenValue * animationPlayNowValue,
                      widget: widget),
                  RippleContainer(
                      height: height,
                      kSizeContainerLogo: kSizeContainerLogo,
                      animationTween:
                          animationTweenValue * animationPlayNowValue,
                      animationRipple: animationRipple),
                  IconContainer(
                    height: height,
                    animationTween: animationTweenValue * animationPlayNowValue,
                    kSizeContainerLogo: kSizeContainerLogo,
                    widget: widget,
                  ),
                  PlayNowButton(
                      animationTween: animationTween.value,
                      heightButton: heightButton,
                      animationButton: animationButton.value,
                      animationPlayNowValue: animationPlayNowValue,
                      function: () {
                        if (isButtonCompleted) {
                          playNowControllerAnimation.forward();
                        }
                      }),
                  LinearProgressBar(
                      heightButton: heightButton,
                      animationButton:
                          animationButton.value * animationPlayNowClick.value,
                      width: width,
                      widget: widget),
                  AnimatedCircles(
                      topContainerCircles: topContainerCircles,
                      bottomContainerCircles: bottomContainerCircles,
                      width: width,
                      animationButton: animationButton,
                      animationPostButton: animationPostButton,
                      moveLeftCircles: moveLeftCircles,
                      animationPlayNowClick: animationPlayNowClick),
                ],
              ),
            )));
  }
}
