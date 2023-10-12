import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      width: 160,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Center(child: Image.asset('assets/images/iphone.png')),
              Positioned(
                right: 10,
                top: 0,
                child: Image.asset(
                  'assets/images/active_fav_product.png',
                  color: Colors.grey,
                  width: 24,
                  height: 24,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
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
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  'آیفون 13 پرو مکس',
                  style: TextStyle(
                    fontFamily: 'SM',
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 53,
                decoration: const BoxDecoration(
                  color: CustomColors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.blue,
                      blurRadius: 25,
                      spreadRadius: -12,
                      offset: Offset(0, 15),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'تومان',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SM',
                            fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '423535000',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'SM',
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '324000000',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SM',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Image(
                        width: 24,
                        image: AssetImage(
                          'assets/images/icon_right_arrow_cricle.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
