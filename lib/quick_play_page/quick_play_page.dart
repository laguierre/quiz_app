import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app/constants.dart';

import '../quiz_page/quiz_page.dart';

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
        duration: const Duration(milliseconds: 2000), vsync: this);
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
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 0),
                    reverseTransitionDuration: const Duration(milliseconds: 350),
                    pageBuilder: (_, __, ___) => QuizPage(data: widget.data)));
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
                  BackButton(widget: widget),
                  Title(
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
                    },
                  ),
                  LinearProgressBar(
                      heightButton: heightButton,
                      animationButton:
                          animationButton.value * animationPlayNowClick.value,
                      width: width,
                      widget: widget),
                  Positioned(
                      top: topContainerCircles,
                      right: 0,
                      left: 0,
                      bottom: bottomContainerCircles,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: -double.parse(circles[0]['size']!) * 0.5,
                            bottom: 0,
                            right: (width - 5) * animationButton.value -
                                double.parse(circles[0]['size']!) +
                                animationPostButton.value +
                                1 * moveLeftCircles,
                            child: TextCircle(
                                animation: animationButton.value,
                                index: 0,
                                animationSize: animationPlayNowClick.value),
                          ),
                          Positioned(
                            top: double.parse(circles[1]['size']!) * 2,
                            bottom: 0,
                            right: (width - 5) * animationButton.value -
                                1.8 * double.parse(circles[1]['size']!) +
                                animationPostButton.value +
                                2 * moveLeftCircles,
                            child: TextCircle(
                                animation: animationButton.value,
                                index: 1,
                                animationSize: animationPlayNowClick.value),
                          ),
                          Positioned(
                            top: -2.5 * double.parse(circles[2]['size']!),
                            bottom: 0,
                            right: (width - 5) * animationButton.value -
                                3.7 * double.parse(circles[2]['size']!) +
                                animationPostButton.value +
                                3 * moveLeftCircles,
                            child: TextCircle(
                              animation: animationButton.value,
                              index: 2,
                              animationSize: animationPlayNowClick.value,
                            ),
                          ),
                          Positioned(
                            top: -0.75 * double.parse(circles[3]['size']!),
                            bottom: -1.2 * double.parse(circles[3]['size']!),
                            right: (width - 5) * animationButton.value -
                                2.35 * double.parse(circles[3]['size']!) +
                                animationPostButton.value +
                                4 * moveLeftCircles,
                            child: TextCircle(
                              animation: animationButton.value,
                              index: 3,
                              animationSize: animationPlayNowClick.value,
                            ),
                          ),
                          Positioned(
                            top: -2.70 * double.parse(circles[4]['size']!),
                            bottom: -1.8 * double.parse(circles[4]['size']!),
                            right: (width - 5) * animationButton.value -
                                3.33 * double.parse(circles[4]['size']!) +
                                animationPostButton.value +
                                5 * moveLeftCircles,
                            child: TextCircle(
                              animation: animationButton.value,
                              index: 4,
                              animationSize: animationPlayNowClick.value,
                            ),
                          ),
                          Positioned(
                            top: 1.6 * double.parse(circles[5]['size']!),
                            bottom: 0,
                            right: (width - 5) * animationButton.value -
                                4.5 * double.parse(circles[5]['size']!) +
                                animationPostButton.value +
                                6 * moveLeftCircles,
                            child: TextCircle(
                              animation: animationButton.value,
                              index: 5,
                              animationSize: animationPlayNowClick.value,
                            ),
                          ),
                          Positioned(
                            top: -1.2 * double.parse(circles[6]['size']!),
                            bottom: -1.2 * double.parse(circles[6]['size']!),
                            right: (width - 5) * animationButton.value -
                                3.35 * double.parse(circles[6]['size']!) +
                                animationPostButton.value +
                                7 * moveLeftCircles,
                            child: TextCircle(
                              animation: animationButton.value,
                              index: 6,
                              animationSize: animationPlayNowClick.value,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }
}

class TextCircle extends StatelessWidget {
  const TextCircle({
    Key? key,
    required this.animation,
    required this.index,
    required this.animationSize,
  }) : super(key: key);
  final double animation;
  final double animationSize;
  final int index;

  @override
  Widget build(BuildContext context) {
    double size = double.parse(circles[index]['size']!);
    String text = circles[index]['title']!;
    Color color = Color(int.parse(circles[index]['color']!));
    return Container(
      alignment: Alignment.center,
      height: size * animation * animationSize,
      width: size * animation * animationSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(text * animation.toInt() * animationSize.toInt(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
    required this.widget,
  });

  final QuickPlayPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 20,
        right: MediaQuery.of(context).size.width - 63,
        top: 50,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'BACK',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(height: 3),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                height: 2,
                color: Color(int.parse(widget.data["color"]!)),
              ),
            ],
          ),
        ));
  }
}

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({
    super.key,
    required this.heightButton,
    required this.animationButton,
    required this.width,
    required this.widget,
  });

  final double heightButton;
  final double animationButton;
  final double width;
  final QuickPlayPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: heightButton + 50,
      child: Opacity(
        opacity: animationButton > 0.2 ? animationButton : 0,
        child: Column(
          children: [
            Text('Waiting for players',
                style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            LinearPercentIndicator(
                width: width - kPadding,
                barRadius: const Radius.circular(5),
                lineHeight: 10.0,
                percent: animationButton,
                backgroundColor: Colors.grey.shade300,
                progressColor: Color(
                  int.parse(widget.data["color"]!),
                )),
          ],
        ),
      ),
    );
  }
}

class PlayNowButton extends StatelessWidget {
  const PlayNowButton({
    super.key,
    required this.animationTween,
    required this.heightButton,
    required this.animationButton,
    required this.function,
    required this.animationPlayNowValue,
  });

  final double animationTween;
  final double heightButton;
  final double animationButton;
  final double animationPlayNowValue;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double opacity = animationPlayNowValue * animationButton;
    return Positioned(
        bottom: (130 * animationTween - 100) * animationPlayNowValue,

        ///Final value: 40
        child: GestureDetector(
          onTap: function,
          child: Container(
            alignment: Alignment.center,
            height: heightButton + (1 - animationPlayNowValue) * height,
            width: (heightButton + width * animationButton)
                .clamp(0, width - 2 * kPadding * animationPlayNowValue),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  (-0.7 * heightButton * animationButton + heightButton) *
                      animationPlayNowValue),
              color: kColorPlayNow,
              boxShadow: [
                BoxShadow(
                  color: kColorPlayNow.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Opacity(
              opacity: opacity > 0.2 ? opacity : 0,
              child: const Text(
                'Play Now',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}

class RippleContainer extends StatelessWidget {
  const RippleContainer({
    super.key,
    required this.height,
    required this.kSizeContainerLogo,
    required this.animationTween,
    required this.animationRipple,
  });

  final double height;
  final double kSizeContainerLogo;
  final double animationTween;
  final Animation<double> animationRipple;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height * 0.23 - (kSizeContainerLogo + 0.15 * height) / 5,
      child: Opacity(
        opacity: animationTween < 0.3 ? 0 : animationTween,
        child: ScaleTransition(
          scale: animationRipple,
          child: Container(
            padding: const EdgeInsets.all(30),
            alignment: Alignment.center,
            height: kSizeContainerLogo + 0.15 * height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo
                      .withOpacity(1 - animationRipple.value.clamp(0, 1)),
                  spreadRadius: 15 * animationRipple.value,
                  blurRadius: 10 * animationRipple.value,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.height,
    required this.animationTween,
    required this.kSizeContainerLogo,
    required this.widget,
  });

  final double height;
  final double animationTween;
  final double kSizeContainerLogo;
  final QuickPlayPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height * 0.23,
      child: Opacity(
        opacity: animationTween < 0.3 ? 0 : animationTween,
        child: Container(
          padding: const EdgeInsets.all(30),
          alignment: Alignment.center,
          height: kSizeContainerLogo,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.3),
                spreadRadius: 15,
                blurRadius: 10,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Image.asset(
            widget.data["icon"]!,
            height: height * 0.15,
            fit: BoxFit.contain,
            color: Color(int.parse(widget.data["color"]!)),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.animationTween,
    required this.widget,
  });

  final double animationTween;
  final QuickPlayPage widget;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0, 1.2 * animationTween - 2),

        ///Final Value 0.8
        child: Text(
          widget.data['title']!,
          style: const TextStyle(
              color: Colors.indigo, fontSize: 45, fontWeight: FontWeight.bold),
        ));
  }
}
