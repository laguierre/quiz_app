import 'package:flutter/material.dart';

class QuickPlayPage extends StatefulWidget {
  const QuickPlayPage({Key? key, required this.data}) : super(key: key);
  final Map<String, String> data;

  @override
  State<QuickPlayPage> createState() => _QuickPlayPageState();
}

class _QuickPlayPageState extends State<QuickPlayPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: -2, end: -0.8).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceIn,
    ))
      ..addListener(() {
        setState(() {});
      });
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
                  Align(
                      alignment: Alignment(0, animation.value),
                      child: Text(
                        widget.data['title']!,
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      )),
                  Align(
                    alignment: Alignment(0, animation.value+0.3),
                    child: Image.asset(
                      widget.data["icon"]!,
                      height: height * 0.15,
                      fit: BoxFit.cover,
                      color: Color(int.parse(widget.data["color"]!)),
                    ),
                  )
                ],
              ),
            )));
  }
}
