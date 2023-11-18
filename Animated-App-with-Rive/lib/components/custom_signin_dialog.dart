// close 할 때 isSignInDialogShown = false 해주려고 {required ValueChanged onClosed} 추가함.
// ???
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/components/sign_in_form.dart';

customSigninDialog(BuildContext context, {required ValueChanged onClosed}) {
  return showGeneralDialog(
    // 바깥을 탭하면 닫히게
    barrierDismissible: true,
    barrierLabel: 'Sign In',
    context: context,
    // 슬라이드 애니메이션
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: ((_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child, // ???
      );
    }),
    pageBuilder: ((context, _, __) => Container(
          height: 600,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            // 요게 배경색
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            // 왜 scaffold...?
            backgroundColor: Colors.transparent,
            body: Stack(
              // close btn 잘리지 않도록
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SignInForm(),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Sign up with Email, Apple or Google',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (() {
                            //
                          }),
                          icon: SvgPicture.asset(
                            'assets/icons/email_box.svg',
                            height: 64,
                            width: 64,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (() {
                            //
                          }),
                          icon: SvgPicture.asset(
                            'assets/icons/google_box.svg',
                            height: 64,
                            width: 64,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (() {
                            //
                          }),
                          icon: SvgPicture.asset(
                            'assets/icons/apple_box.svg',
                            height: 64,
                            width: 64,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // close btn
                const Positioned(
                  right: 0,
                  left: 0,
                  bottom: -48,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        )),
  ).then(onClosed);
}
