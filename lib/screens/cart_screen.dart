import 'package:digikala_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Image(
                            image:
                                AssetImage('assets/images/icon_apple_blue.png'),
                          ),
                          Expanded(
                            child: Text(
                              'سبد خرید',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                                color: CustomColors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const CartItem(),
                    childCount: 5,
                  ),
                ),
                const SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 32)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: SizedBox(
                height: 53,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  child: const Text(
                    'ادامه فرآیند خرید',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'SM',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('آیفون 13 پرومکس'),
                        const Text('data'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 2),
                                child: Text(
                                  '%3',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const Text('تومان'),
                            const Text(
                              '123456000',
                              style: TextStyle(fontFamily: 'SM'),
                            ),
                          ],
                        ),
                        OptionChip(title: 'test'),
                        OptionChip(
                          title: 'test',
                        ),
                        OptionChip(
                          title: 'test',
                        ),
                      ],
                    ),
                  ),
                ),
                const Image(image: AssetImage('assets/images/iphone.png')),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              indent: 12,
              endIndent: 12,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تومان',
                  style: TextStyle(fontFamily: 'SB'),
                ),
                SizedBox(width: 5),
                Text('114,814,080', style: TextStyle(fontFamily: 'SB')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionChip extends StatelessWidget {
  String? color;
  String title;
  OptionChip({
    super.key,
    this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    int hexColor = int.parse('ff${color}', radix: 16);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: CustomColors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            if (color != null) ...{
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(hexColor),
                ),
              ),
            },
            Text(title),
          ],
        ),
      ),
    );
  }
}
