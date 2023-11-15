import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

List<Color> bgColors = [Colors.black, Colors.purple, Colors.blue];

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
              for (var index in [0, 1, 2])
                Hero(
                  tag: '$index',
                  child: CreditCard(index: index, isExpanded: _isExpanded)
                      .animate(
                        delay: 1.5.seconds,
                        // target은 애니메이션 진행 정도. 0부터 1까지의 범위를 가진다.
                        // _isExpanded의 상태에 따라 target이 달라진다.
                        target: _isExpanded ? 0 : 1,
                      )
                      .flipV(end: 0.1) // vertical flip
                      .slideY(end: -0.8 * index),
                ),
              // CreditCard(index: 1, isExpanded: _isExpanded)
              //     .animate(
              //       delay: 1.5.seconds,
              //       target: _isExpanded ? 0 : 1,
              //     )
              //     .flipV(end: 0.1)
              //     .slideY(end: -0.8), // end: -1이면 첫번째 카드를 전부 덮음
              // CreditCard(index: 2, isExpanded: _isExpanded)
              //     .animate(
              //       delay: 1.5.seconds,
              //       target: _isExpanded ? 0 : 1,
              //     )
              //     .flipV(end: 0.1)
              //     .slideY(end: -0.8 * 2),
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

class CreditCard extends StatefulWidget {
  final int index;
  final bool isExpanded;

  const CreditCard({super.key, required this.index, required this.isExpanded});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  void _onTap() {
    // print('tap');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(index: widget.index),
        // fullscreenDialog: true 하면 화면이 아래서부터 나타남
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 카드들이 위로 쌓였을 경우에는 Container 위젯의 onTap 이벤트가 아니라
    // Column의 onTap 이벤트를 실행시켜야 한다.

    // Hero 위젯을 사용하고 다음 페이지로 넘길 때 scaffold 안에 포함되지 않아 오류가 발생하므로
    // Material 위젯으로 감싸서 오류 해결
    return Material(
      type: MaterialType.transparency,
      child: AbsorbPointer(
        // absorbing: true일 경우 이벤트를 캔슬시킴.
        absorbing: !widget.isExpanded,
        child: GestureDetector(
          onTap: _onTap,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgColors[widget.index],
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
      ),
    );
  }
}

class CardDetailScreen extends StatelessWidget {
  final int index;

  const CardDetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: '$index',
              // isExpanded: true면 CreditCard 위젯의 onTap 이벤트가 디테일 페이지로 넘어와도 계속 실행돼서
              // 페이지가 계속 쌓인다.
              child: CreditCard(index: index, isExpanded: false),
            ),
            ...[
              for (var _ in [1, 1, 1, 1, 1])
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    tileColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: const Icon(Icons.shopping_bag),
                    ),
                    title: const Text('교보문고', style: TextStyle(fontSize: 18)),
                    subtitle: Text('강남점',
                        style: TextStyle(color: Colors.grey.shade800)),
                    trailing: const Text(
                      '31,000원',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
            ]
                .animate(interval: 500.milliseconds)
                .fadeIn(begin: 0)
                .flipV(begin: -0.5, end: 0, curve: Curves.elasticInOut),
          ],
        ),
      ),
    );
  }
}
