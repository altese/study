import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Implicit Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🍋 TweenAnimationBuilder
            TweenAnimationBuilder(
              /* 
                Tween
                  - 어디서 어디까지 애니메이션 효과를 추가하고 싶은지 설정 가능
                  - 애니메이션의 시작값과 목표값이 있는 object
                  - between에서 유래 
               */
              // tween: Tween(begin: 10.0, end: 20.0),
              tween: ColorTween(begin: Colors.pink[300], end: Colors.cyan[300]),

              curve: Curves.bounceInOut,
              duration: const Duration(seconds: 5),
              // builder: 현재 애니메이션이 적용되는 값으로 호출될 함수
              // value가 Tween에서 지정한 값인 듯
              builder: (context, value, child) {
                return Image.network(
                  'https://tse2.mm.bing.net/th?id=OIP.dySr6Vf8YxnEiL-JhGttQwHaHy&pid=Api&P=0&h=220',
                  color: value,
                  colorBlendMode: BlendMode.hue,
                );
              },
            ),

            // 🍋 AnimatedContainer
            // AnimatedContainer(
            //   curve: Curves.elasticOut,
            //   // curve: Curves.bounceOut,
            //   duration: const Duration(seconds: 2),
            //   width: size.width * 0.8,
            //   height: size.width * 0.8,
            //   // width: _visible ? size.width * 0.9 : size.width * 0.6,
            //   // height: _visible ? size.width * 0.9 : size.width * 0.6,
            //   transform: Matrix4.rotationZ(_visible ? 1 : 0),
            //   transformAlignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     color: _visible ? Colors.pink : Colors.cyan,
            //     borderRadius: BorderRadius.circular(_visible ? 100 : 20),
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: _trigger, child: const Text('Go'))
          ],
        ),
      ),
    );
  }
}
