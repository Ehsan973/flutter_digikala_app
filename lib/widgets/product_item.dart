import 'package:digikala_app/bloc/basket/basket_bloc.dart';
import 'package:digikala_app/data/model/product.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/screens/product_detail_screen.dart';
import 'package:digikala_app/util/extentions/int_extentions.dart';
import 'package:digikala_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: ProductDetailScreen(
                product: product,
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 165,
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
                Center(
                  child: SizedBox(
                    height: 98,
                    width: 98,
                    child: CachedImage(
                      imageUrl: product.thumbnail,
                    ),
                  ),
                ),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2),
                      child: Text(
                        '%${product.percent!.round()}',
                        style: const TextStyle(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'تومان',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SM',
                              fontSize: 12),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.price.convertToPrice(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'SM',
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              product.realPrice.convertToPrice(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'SM',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Image(
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
      ),
    );
  }
}
