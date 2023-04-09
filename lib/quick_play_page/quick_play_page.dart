import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app/constants.dart';

class QuickPlayPage extends StatefulWidget {
  const QuickPlayPage({Key? key, required this.data}) : super(key: key);
  final Map<String, String> data;

  @override
  State<QuickPlayPage> createState() => _QuickPlayPageState();
}

class _QuickPlayPageState extends State<QuickPlayPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationRippleController;
  late AnimationController animationCascadeController;
  late Animation<double> animationTween;
  late Animation<double> animationRipple;
  late Animation<double> animationButton;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animationRippleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animationCascadeController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    animationTween = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    ))
      ..addListener(() {
        if (animationController.isCompleted) {
          animationRippleController.repeat();
          animationCascadeController.forward();
        }
        setState(() {});
      });
    animationRipple =
        Tween<double>(begin: 0.4, end: 1.0).animate(animationRippleController)
          ..addListener(() {
            setState(() {});
          });

    ///Button Animation
    animationButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationCascadeController, curve: const Interval(0.0, 0.33)),
    )..addListener(() {
        setState(() {});
      });
    animationRippleController.repeat();
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double kSizeContainerLogo = height * 0.25;
    double heightButton = 75.0;
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
                  Positioned(
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
                              //width: 35,
                              color: Color(int.parse(widget.data["color"]!)),
                            ),
                          ],
                        ),
                      )),
                  Title(animationTween: animationTween, widget: widget),
                  RippleContainer(
                      height: height,
                      kSizeContainerLogo: kSizeContainerLogo,
                      animationTween: animationTween,
                      animationRipple: animationRipple),
                  IconContainer(
                    height: height,
                    animationTween: animationTween,
                    kSizeContainerLogo: kSizeContainerLogo,
                    widget: widget,
                  ),
                  PlayNowButton(
                      animationTween: animationTween,
                      heightButton: heightButton,
                      animationButton: animationButton),
                  Positioned(

                    bottom: heightButton + 70,
                    child: Opacity(
                      opacity: animationButton.value > 0.2? animationButton.value : 0,
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
                              lineHeight: 14.0,
                              percent: animationButton.value,
                              backgroundColor: Colors.grey.shade300,
                              progressColor: Color(
                                int.parse(widget.data["color"]!),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class PlayNowButton extends StatelessWidget {
  const PlayNowButton({
    super.key,
    required this.animationTween,
    required this.heightButton,
    required this.animationButton,
  });

  final Animation<double> animationTween;
  final double heightButton;
  final Animation<double> animationButton;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 140 * animationTween.value - 100,

        ///Final value: 40
        child: Container(
          alignment: Alignment.center,
          height: heightButton,
          width: heightButton +
              (MediaQuery.of(context).size.width - heightButton - 2* kPadding) *
                  animationButton.value,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                -0.7 * heightButton * animationButton.value + heightButton),
            color: Colors.indigo,
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Opacity(
            opacity: animationButton.value > 0.2 ? animationButton.value : 0,
            child: const Text(
              'Play Now',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
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
  final Animation<double> animationTween;
  final Animation<double> animationRipple;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height * 0.23 - (kSizeContainerLogo + 0.15 * height) / 5,
      child: Opacity(
        opacity: animationTween.value < 0.3 ? 0 : animationTween.value,
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
  final Animation<double> animationTween;
  final double kSizeContainerLogo;
  final QuickPlayPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height * 0.23,
      child: Opacity(
        opacity: animationTween.value < 0.3 ? 0 : animationTween.value,
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

  final Animation<double> animationTween;
  final QuickPlayPage widget;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0, 1.2 * animationTween.value - 2),

        ///Final Value 0.8
        child: Text(
          widget.data['title']!,
          style: const TextStyle(
              color: Colors.indigo, fontSize: 45, fontWeight: FontWeight.bold),
        ));
  }
}
