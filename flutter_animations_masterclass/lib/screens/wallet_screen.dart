import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isExpanded = false;

  // void _toggleExpanded() {
  //   setState(() {
  //     _isExpanded = !_isExpanded;
  //   });
  // }

  // 카드들이 펼쳐진다.
  void _onExpand() {
    setState(() {
      _isExpanded = true;
    });
  }

  // 카드들이 위로 접힌다.
  void _onShrink() {
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onVerticalDragEnd: (_) => _onShrink(),
          onTap: _onExpand,
          child: Column(
            children: [
              CreditCard(bgColor: Colors.purple, isExpanded: _isExpanded)
                  .animate(
                    delay: 1.5.seconds,
                    // target은 애니메이션 진행 정도. 0부터 1까지의 범위를 가진다.
                    // _isExpanded의 상태에 따라 target이 달라진다.
                    target: _isExpanded ? 0 : 1,
                  )
                  .flipV(end: 0.1), // vertical flip
              CreditCard(bgColor: Colors.black, isExpanded: _isExpanded)
                  .animate(
                    delay: 1.5.seconds,
                    target: _isExpanded ? 0 : 1,
                  )
                  .flipV(end: 0.1)
                  .slideY(end: -0.8), // end: -1이면 첫번째 카드를 전부 덮음
              CreditCard(bgColor: Colors.blue, isExpanded: _isExpanded)
                  .animate(
                    delay: 1.5.seconds,
                    target: _isExpanded ? 0 : 1,
                  )
                  .flipV(end: 0.1)
                  .slideY(end: -0.8 * 2),
            ]
                .animate(interval: 500.ms)
                .slideX(begin: -1, end: 0)
                .fadeIn(begin: 0),
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  final Color bgColor;
  final bool isExpanded;

  const CreditCard(
      {super.key, required this.bgColor, required this.isExpanded});

  void _onTap() {
    print('tap');
  }

  @override
  Widget build(BuildContext context) {
    // 카드들이 위로 쌓였을 경우에는 Container 위젯의 onTap 이벤트가 아니라
    // Column의 onTap 이벤트를 실행시켜야 한다.
    return AbsorbPointer(
      // absorbing: true일 경우 이벤트를 캔슬시킴.
      absorbing: !isExpanded,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Park Yejin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '**** **** *** **75',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      // Clip.none: 원이 잘리는 것 방지!!
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
