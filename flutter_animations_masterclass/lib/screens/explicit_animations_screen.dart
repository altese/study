import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
    reverseDuration: const Duration(seconds: 1),
    // lowerBound: 0,
    // upperBound: 100.0,
  )..addListener(() {
      // setState(() {
      _value.value = _animationController.value;
      // });
    });
  // 애니메이션이 완료되었는지 여부를 알려 주는 StatusListener
  // 애니메이션이 끝난 뒤 실행시키고 싶은 코드가 있을 때 유용함
  // ..addStatusListener((status) {
  //   //
  //   if (status == AnimationStatus.completed) {
  //     _animationController.reverse();
  //   } else if (status == AnimationStatus.dismissed) {
  //     _animationController.forward();
  //   }
  // });

  /* for AnimatedBuilder */
  // late final Animation<Color?> _color = ColorTween(
  //   begin: Colors.amber,
  //   end: Colors.red,
  // ).animate(_animationController);

  // late final Animation<Decoration> _decoration = DecorationTween(
  //   begin: BoxDecoration(
  //     color: Colors.amber,
  //     borderRadius: BorderRadius.circular(20),
  //   ),
  //   end: BoxDecoration(
  //     color: Colors.red,
  //     borderRadius: BorderRadius.circular(100),
  //   ),
  // ).animate(_animationController);

  // late final Animation<double> _rotation = Tween(
  //   begin: 0.0,
  //   end: 2.0,
  // ).animate(_animationController);

  // late final Animation<double> _scale = Tween(
  //   begin: 1.0,
  //   end: 1.1,
  // ).animate(_animationController);

  // late final Animation<Offset> _position = Tween(
  //   begin: Offset.zero,
  //   end: const Offset(0, -.5), // 자식 크기의 0.5 만큼 위로 이동
  // ).animate(_animationController);

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(100),
    ),
  ).animate(_curveBounceOut);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_curveElasticOut);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 1.1,
  ).animate(_curveElasticOut);

  late final Animation<Offset> _position = Tween(
    begin: Offset.zero,
    end: const Offset(0, -.2), // 자식 크기의 0.5 만큼 위로 이동
  ).animate(_curveElasticOut);

  // ✨ curve를 만듭시당!!
  late final CurvedAnimation _curveElasticOut = CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticOut,
    reverseCurve: Curves.bounceIn,
  );

  late final CurvedAnimation _curveBounceOut = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  // 애니메이션 실행
  void _play() {
    _animationController.forward();
  }

  // 애니메이션 멈춤
  void _pause() {
    _animationController.stop();
  }

  // 애니메이션 되감기
  void _rewind() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 무한 루프를 실행하는 함수
  bool _looping = false;

  void _toggleLooping() {
    if (_looping) {
      _animationController.stop();
    } else {
      // reverse는 애니메이션이 끝까지 실행되면 거기서부터 시작하도록 만드는 옵션
      // (맨 처음으로 점프하지 않음)
      _animationController.repeat(reverse: true);
    }

    setState(() {
      _looping = !_looping;
    });
  }

  // for Slider
  // double _value = 0.0;
  final ValueNotifier<double> _value = ValueNotifier(0.0);

  void _onChanged(double value) {
    // setState(() {
    //   _value = value;
    // });
    _value.value = 0;
    _animationController.animateTo(value);
  }

  @override
  void initState() {
    super.initState();
    // Ticker: 각 애니메이션 프레임당 한 번 콜백을 호출한다.
    // Ticker((elapsed) {
    //   print(elapsed);
    // }).start();

    // 0.5초마다 실행
    // Timer.periodic(const Duration(microseconds: 500), (timer) {
    //   print(_animationController.value);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('explicit animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* for AnimatedBuilder */
            // AnimatedBuilder(
            //   animation: _animationController,
            //   builder: (context, child) {
            //     // _animationController.value가 변경될 때마다 호출
            //     return Container(
            //       height: 100,
            //       width: 100,
            //       decoration: BoxDecoration(
            //           color: _color.value,
            //           borderRadius: BorderRadius.all(
            //               Radius.circular(_animationController.value))),
            //     );
            //   },
            // ),

            SlideTransition(
              position: _position,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                    decoration: _decoration,
                    child: const SizedBox(
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _play, child: const Text('play')),
                ElevatedButton(onPressed: _pause, child: const Text('pause')),
                ElevatedButton(onPressed: _rewind, child: const Text('rewind')),
                ElevatedButton(
                    onPressed: _toggleLooping, child: const Text('looping')),
              ],
            ),
            const SizedBox(height: 25),
            ValueListenableBuilder(
              valueListenable: _value,
              builder: (context, value, child) {
                print('object');
                return Slider(value: value, onChanged: _onChanged);
              },
            )
          ],
        ),
      ),
    );
  }
}
