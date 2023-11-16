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
  // 만든 것을 색상으로 칠해 준다.
  @override
  void paint(Canvas canvas, Size size) {
    // 좌측 상단 모서리가 (0,0)
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..color = Colors.blue;
    // drawRect: 주어진 paint로 사각형을 그림
    canvas.drawRect(rect, paint);
    final circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    // 중심(offset), 반지름, paint
    canvas.drawCircle(
        Offset(size.width / 2, size.width / 2), size.width / 2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
