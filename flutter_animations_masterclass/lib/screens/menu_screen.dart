import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/swiping_cards_screen.dart';
import 'package:flutter_animations_masterclass/screens/wallet_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flutter animation')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImplicitAnimationsScreen());
              },
              child: const Text('Implicit Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ExplicitAnimationScreen());
              },
              child: const Text('Explicit Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const SwipingCardsScreen());
              },
              child: const Text('Swiping'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const WalletScreen());
              },
              child: const Text('Wallet, flutter_animate'),
            ),
          ],
        ),
      ),
    );
  }
}
