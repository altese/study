import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),

    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0, // 기본적으로 value는 lowerBound에서 초기화되기 때문에 0으로 바꿔 준다.
  );

  // double posX = 0; // position X

  // 카드의 위치에 따라 회전시킬 tween
  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  // 뒤에 놓인 카드 크기
  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    // details는 Offset임! x좌표, y좌표
    // delta는 움직인 거리? 양?을 알 수 있다. 얼마나 움직였는지 알 수 있음.
    // delta.dx는 print가 찍히고 리셋, 다음 print까지 움직인 거리임.
    // delta.dx는 print가 찍히고 리셋되기 때문에 얼마나 이동했는지 알려면 누적해야 한다.
    // posX += details.delta.dx;
    // setState(() {});

    _animationController.value += details.delta.dx;
  }

  void _whenComplete() {
    _animationController.value = 0;
    setState(() {
      _index = _index == 5 ? 1 : _index + 1;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    // posX = 0;
    // setState(() {});

    // bound를 넘어가면 카드가 없어진다.
    final bound = size.width - 200;
    final dropZone = size.width + 100;

    if (_animationController.value.abs() >= bound) {
      final factor = _animationController.value.isNegative ? -1 : 1;
      _animationController
          .animateTo((dropZone) * factor, curve: Curves.easeOut)
          .whenComplete(_whenComplete);
      // if (_animationController.value.isNegative) {
      //   _animationController
      //       .animateTo((dropZone) * -1)
      //       .whenComplete(_whenComplete);
      // } else {
      //   // animateTo()에 들어가는 값은 화면보다 크게 만들어서 화면에서 안 보이게 해야 됨
      //   // -> animationController 하한값, 상한값 조정
      //   _animationController.animateTo(dropZone).whenComplete(_whenComplete);
      // }
    } else {
      // 0까지 애니메이션
      _animationController.animateTo(0, curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swiping Cards')),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          // 보간
          final angle = _rotation.transform(
                  (_animationController.value + size.width / 2) / size.width) *
              // 단위를 라디안으로 변환
              pi /
              180;
          final scale =
              _scale.transform(_animationController.value.abs() / size.width);
          print(scale);

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: min(scale, 1.005),
                  // scale: scale,
                  child: Card(index: _index == 5 ? 1 : _index + 1),
                  // Material(
                  //   elevation: 10,
                  //   color: Colors.blue.shade100,
                  //   child: SizedBox(
                  //     width: size.width * 0.8,
                  //     height: size.height * 0.5,
                  //   ),
                  // ),
                ),
              ),
              Positioned(
                top: 100,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    // 가로로 드래그하는 이벤트
                    onHorizontalDragUpdate: _onHorizontalDragUpdate,
                    // 가로 드래그가 끝났을 때
                    onHorizontalDragEnd: _onHorizontalDragEnd,
                    // Transform.translate: 카드를 평행이동시켜줌
                    child: Transform.translate(
                      // offset에는 Offset(x축 이동량, y축 이동량) 요렇게 들어간다.
                      offset: Offset(_animationController.value, 0),
                      // 📝 Material
                      child: Transform.rotate(
                        angle: angle,
                        // child: Material(
                        //   elevation: 10,
                        //   color: Colors.red.shade100,
                        //   child: SizedBox(
                        //     width: size.width * 0.8,
                        //     height: size.height * 0.5,
                        //   ),
                        // ),
                        child: Card(index: _index),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;

  const Card({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    late final size = MediaQuery.of(context).size;

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Image.asset(
          'assets/covers/$index.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
