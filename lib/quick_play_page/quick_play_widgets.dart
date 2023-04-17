import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app/quick_play_page/quick_play_page.dart';

import '../constants.dart';


class AnimatedCircles extends StatelessWidget {
  const AnimatedCircles({
    super.key,
    required this.topContainerCircles,
    required this.bottomContainerCircles,
    required this.width,
    required this.animationButton,
    required this.animationPostButton,
    required this.moveLeftCircles,
    required this.animationPlayNowClick,
  });

  final double topContainerCircles;
  final double bottomContainerCircles;
  final double width;
  final Animation<double> animationButton;
  final Animation<double> animationPostButton;
  final double moveLeftCircles;
  final Animation<double> animationPlayNowClick;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
        ));
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

class BackButtonQuiz extends StatelessWidget {
  const BackButtonQuiz({
    super.key,
    required this.widget,
  });

  final QuickPlayPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 20,
        right: MediaQuery
            .of(context)
            .size
            .width - 63,
        top: 50,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'BACK',
                style: TextStyle(
                    color: kColorPlayNow,
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
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
                  color: kColorPlayNow
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
                color: kColorPlayNow.withOpacity(0.3),
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

class TitleQuiz extends StatelessWidget {
  const TitleQuiz({
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
          style: TextStyle(
              color: kColorPlayNow, fontSize: 45, fontWeight: FontWeight.bold),
        ));
  }
}
