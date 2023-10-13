import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_icon_item_chip.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'جستجوی محصولات',
                                hintStyle: TextStyle(
                                  fontFamily: 'SB',
                                  color: CustomColors.grey,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(
                          image: AssetImage('assets/images/icon_search.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: BannerSlider(),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(
                    'دسته بندی',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontFamily: 'SB', color: CustomColors.grey),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 85,
                  child: _getCategoryList(),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(children: [
                    Image(
                        image:
                            AssetImage('assets/images/icon_left_categroy.png')),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'مشاهده همه',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: CustomColors.blue,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'پرفروش ترین ها',
                      style:
                          TextStyle(fontFamily: 'SB', color: CustomColors.grey),
                    ),
                  ]),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 210,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(left: 10, right: 40)
                              : const EdgeInsets.symmetric(horizontal: 10),
                          child: const ProductItem(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 12,
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(children: [
                    Image(
                        image:
                            AssetImage('assets/images/icon_left_categroy.png')),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'مشاهده همه',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: CustomColors.blue,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'پربازدید ترین ها',
                      style:
                          TextStyle(fontFamily: 'SB', color: CustomColors.grey),
                    ),
                  ]),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 210,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index == 0
                              ? const EdgeInsets.only(left: 10, right: 40)
                              : const EdgeInsets.symmetric(horizontal: 10),
                          child: const ProductItem(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCategoryList() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(left: 10, right: 40)
                : const EdgeInsets.symmetric(horizontal: 10),
            child: const CategoryItemChip(),
          );
        },
      ),
    );
  }
}
