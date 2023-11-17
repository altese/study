import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatch extends StatefulWidget {
  const AppleWatch({super.key});

  @override
  State<AppleWatch> createState() => _AppleWatchState();
}

class _AppleWatchState extends State<AppleWatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Apple Watch'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        // 그림 그릴 캔버스
        child: CustomPaint(
          painter: AppleWatchPainter(),
          size: const Size(350, 350),
        ),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // draw red
    final redCirclePaint = Paint()
      ..color = Colors.red.shade500.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, (size.width / 2) * 0.9, redCirclePaint);

    // draw green
    final greenCirclePaint = Paint()
      ..color = Colors.green.shade500.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, (size.width / 2) * 0.7, greenCirclePaint);

    // draw blue
    final blueCirclePaint = Paint()
      ..color = Colors.blue.shade500.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, (size.width / 2) * 0.5, blueCirclePaint);

    // red arc
    final redArcRect =
        Rect.fromCircle(center: center, radius: (size.width / 2) * 0.9);
    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      // 테두리
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    // rect: 호를 그릴 캔버스, starcAngle: 시작 각도, sweepAngle: 끝날 각도, useCenter: 중심, paint: 그리기
    canvas.drawArc(redArcRect, -0.5 * pi, 1.5 * pi, false, redArcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
