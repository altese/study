import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatch extends StatefulWidget {
  const AppleWatch({super.key});

  @override
  State<AppleWatch> createState() => _AppleWatchState();
}

class _AppleWatchState extends State<AppleWatch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
    /* AnimatinController의 값에 하한, 상한이 지정되는 게 아니라 Tween을 쓸 거면 Tween에 있어야 함!

     lowerBound: 0.005,
     upperBound: 2.0,
     */

    // 화면에 들어오자마자 애니메이션 실행
  )..forward();

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );
  // final random = Random();
  final end = Random().nextDouble() * 1.5;

  late Animation<double> _progress = Tween(
    begin: 0.005,
    end: end,
  ).animate(_curve);

  // 랜덤한 값으로 애니메이션 값을 바꾸는 함수
  void _animateValues() {
    // _animationController.forward();

    // 트윈이 끝난 지점
    final newBegin = _progress.value;
    // 위의 지점부터 진행될 새로운 끝 지점을 계산
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;
    setState(() {
      _progress = Tween(
        begin: newBegin,
        end: newEnd,
      ).animate(_curve);
    });

    // 애니메이션이 0부터 다시 시작되도록 설정
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
        child: AnimatedBuilder(
          animation: _progress,
          builder: (context, child) {
            // 그림 그릴 캔버스
            return CustomPaint(
              painter: AppleWatchPainter(progress: _progress.value),
              size: const Size(350, 350),
            );
          },
        ),
      ),
      // 새로고침 버튼: 애니메이션을 실행시킴
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;

  AppleWatchPainter({super.repaint, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final redCircleRadius = (size.width / 2) * 0.9;
    final greenCircleRadius = (size.width / 2) * 0.7;
    final blueCircleRadius = (size.width / 2) * 0.5;

    const startAngle = -0.5 * pi;

    // draw red
    final redCirclePaint = Paint()
      ..color = Colors.red.shade500.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, redCircleRadius, redCirclePaint);

    // draw green
    final greenCirclePaint = Paint()
      ..color = Colors.green.shade500.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, greenCircleRadius, greenCirclePaint);

    // draw blue
    final blueCirclePaint = Paint()
      ..color = Colors.blue.shade500.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, blueCircleRadius, blueCirclePaint);

    // arcs ========================================================================

    // red arc
    final redArcRect = Rect.fromCircle(center: center, radius: redCircleRadius);
    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      // 테두리
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    // rect: 호를 그릴 캔버스, startAngle: 시작 각도, sweepAngle: 끝날 각도,
    // useCenter: 중심, paint: 그리기
    canvas.drawArc(redArcRect, startAngle, progress * pi, false, redArcPaint);

    // green arc
    final greenArcRect =
        Rect.fromCircle(center: center, radius: greenCircleRadius);
    final greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
        greenArcRect, startAngle, progress * pi, false, greenArcPaint);

    // blue arc
    final blueArcRect =
        Rect.fromCircle(center: center, radius: blueCircleRadius);
    final blueArcPaint = Paint()
      ..color = Colors.blue.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(blueArcRect, startAngle, progress * pi, false, blueArcPaint);
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    // oldDelegate를 이용해서 새로운 값을 받았을 때 이전 값과 현재 값이 다를 때만 다시 그리도록 설정.
    return oldDelegate.progress != progress;
  }
}
