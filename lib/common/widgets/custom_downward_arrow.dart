import 'package:flutter/material.dart';

class DownwardArrowContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;

  DownwardArrowContainer({
    required this.width,
    required this.height,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: AlignmentDirectional.bottomStart,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: ArrowPainter(color: color),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;

  ArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 10)
      ..lineTo(size.width / 2.5, size.height)
      ..lineTo(0, size.height - 10)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
