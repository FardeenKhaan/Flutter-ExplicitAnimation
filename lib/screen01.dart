import 'package:flutter/material.dart';

class Screen01 extends StatefulWidget {
  const Screen01({super.key});

  @override
  State<Screen01> createState() => _Screen01State();
}

class _Screen01State extends State<Screen01>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _sizeAnimation = Tween<double>(begin: 50, end: 200)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _borderRadiusAnimation = Tween<double>(begin: 0, end: 50)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animations in Flutter'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius:
                    BorderRadius.circular(_borderRadiusAnimation.value),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.repeat(reverse: true);
          }
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
