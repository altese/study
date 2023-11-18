import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    super.key,
    required RiveAnimationController btnAnimationController,
    required this.press,
  }) : _btnAnimationController = btnAnimationController;

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press; // ⭐️⭐️⭐️ VoidCallback?

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              // button에 애니메이션 넣기!
              controllers: [_btnAnimationController],
            ),
            const Positioned.fill(
              // ⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️
              top: 8, // mainAxisAlignment.center가 안 먹혀서 8 넣어줌
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(width: 8),
                  Text(
                    'Start the course',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
