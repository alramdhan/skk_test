import 'package:flutter/material.dart';

class NeonBGContainer extends StatelessWidget {
  const NeonBGContainer({
    Key? key,
    required this.colors,
    required this.animation,
    required this.alignment,
    required this.width,
    required this.height
  }) : super(key: key);

  final Animation<double> animation;
  final List<Color> colors;
  final Alignment alignment;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value,
      alignment: alignment,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),
      ),
    );
  }
}