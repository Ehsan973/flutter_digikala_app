import 'package:digikala_app/bloc/basket/basket_bloc.dart';
import 'package:digikala_app/bloc/basket/basket_event.dart';
import 'package:digikala_app/bloc/basket/basket_state.dart';
import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/data/model/basket_item.dart';
import 'package:digikala_app/util/extentions/string_extentions.dart';
import 'package:digikala_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(builder: (context, state) {
          return Stack(
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
                              image: AssetImage(
                                  'assets/images/icon_apple_blue.png'),
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
                  if (state is BasketDataFetchedState) ...{
                    state.basketItemListEither.fold(
                      (l) => SliverToBoxAdapter(child: Text(l)),
                      (basketItemList) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                CartItem(basketItem: basketItemList[index]),
                            childCount: basketItemList.length,
                          ),
                        );
                      },
                    ),
                  },
                  const SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 32)),
                ],
              ),
              if (state is BasketDataFetchedState) ...{
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: SizedBox(
                    height: 53,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<BasketBloc>()
                            .add(BasketPaymentInitEvent());

                        context
                            .read<BasketBloc>()
                            .add(BasketPaymentRequestEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.green,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      child: Text(
                        state.basketFinalPrice == 0
                            ? 'سبد خرید شما خالی می باشد'
                            : '${state.basketFinalPrice}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'SM',
                        ),
                      ),
                    ),
                  ),
                ),
              },
            ],
          );
        }),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  BasketItem basketItem;
  CartItem({
    super.key,
    required this.basketItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 100 * 31,
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
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          basketItem.name,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontFamily: 'SB',
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          'گارانتی فیلان 18 ماهه',
                          style: TextStyle(fontFamily: 'SM', fontSize: 10),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
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
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              'تومان',
                              style: TextStyle(fontFamily: 'SM', fontSize: 12),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            const Text(
                              '123456000',
                              style: TextStyle(
                                fontFamily: 'SM',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          textDirection: TextDirection.rtl,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            OptionChip(
                              title: 'قرمز',
                              color: 'FF1212',
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: CustomColors.red),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'حذف',
                                      style: TextStyle(
                                        fontFamily: 'sm',
                                        fontSize: 12,
                                        color: CustomColors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Image(
                                      image: AssetImage(
                                          'assets/images/icon_trash.png'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CachedImage(imageUrl: basketItem.thumbnail),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Divider(
              indent: 12,
              endIndent: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'تومان',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  '${basketItem.realPrice}',
                  style: const TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                  ),
                ),
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: CustomColors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parseToColor(),
                ),
              ),
            },
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String? _extractValueFromQuery(String url, String key) {
  int queryStartIndex = url.indexOf('?');
  if (queryStartIndex == -1) return null;

  String query = url.substring(queryStartIndex + 1);

  List<String> pairs = query.split('&');

  for (String pair in pairs) {
    List<String> keyValue = pair.split('=');
    if (keyValue.length == 2) {
      String currentKey = keyValue[0];
      String value = keyValue[1];

      if (currentKey == key) {
        return Uri.decodeComponent(value);
      }
    }
  }

  return null;
}
