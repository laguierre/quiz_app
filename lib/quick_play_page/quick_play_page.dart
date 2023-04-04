import 'package:flutter/material.dart';

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
  late Animation<double> animationTween;
  late Animation<double> animationRipple;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animationRippleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animationTween = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceIn,
    ))
      ..addListener(() {
        if (animationController.isCompleted) {
          animationRippleController.repeat();
        }
        setState(() {});
      });
    animationRipple =
        Tween<double>(begin: 0.4, end: 1.0).animate(animationRippleController)
          ..addListener(() {
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
    double kSizeContainerLogo = height * 0.25;
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
                  Stack(
                    children: [
                      Align(
                          alignment:
                              Alignment(0, 1.2 * animationTween.value - 2),
                          ///Final Value 0.8
                          child: Text(
                            widget.data['title']!,
                            style: const TextStyle(
                                color: Colors.indigo,
                                fontSize: 45,
                                fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: height * 0.23 - (kSizeContainerLogo + 0.15 * height)/5,
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
                                  color: Colors.indigo.withOpacity(1-animationRipple.value.clamp(0, 1)),
                                  spreadRadius: 15 * animationRipple.value,
                                  blurRadius: 10* animationRipple.value,
                                  offset:
                                      const Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: height * 0.23,
                    child: Opacity(
                      opacity:
                          animationTween.value < 0.2 ? 0 : animationTween.value,
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
                              offset:
                                  const Offset(0, 0), // changes position of shadow
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
                  )
                ],
              ),
            )));
  }
}
