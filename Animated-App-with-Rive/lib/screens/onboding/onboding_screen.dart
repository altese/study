import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/components/custom_signin_dialog.dart';

import '../../components/animated_btn.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isSignInDialogShown = false;
  // button에 애니메이션 넣기!
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false, // initState에서는 애니 재생 x
    ); // ⭐️⭐️⭐️
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 고정 image
          Positioned(
            // height: 100,
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset('assets/Backgrounds/Spline.png'),
          ),
          // blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          // 배경 animation
          const RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
            fit: BoxFit.fill,
          ),
          //blur 채우기
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          // text
          // 버튼 클릭 시 화면이 살짝 위로 올라가는 애니메이션
          AnimatedPositioned(
            top: isSignInDialogShown ? -50 : 0,
            duration: const Duration(milliseconds: 200),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            'Learn design & code',
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2), // ⭐️⭐️⭐️
                    // animated button
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        // 버튼 애니메이션 보여진 후에 dialog 띄우도록 delay
                        Future.delayed(const Duration(milliseconds: 800), () {
                          customSigninDialog(
                            context,
                            onClosed: (_) {
                              setState(() {
                                isSignInDialogShown = false;
                              });
                            },
                          );
                          setState(() {
                            isSignInDialogShown = true;
                          });
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry\'s standard dummy text',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
