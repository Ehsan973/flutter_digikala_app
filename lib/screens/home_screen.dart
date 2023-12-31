import 'package:digikala_app/bloc/home/home_event.dart';
import 'package:digikala_app/bloc/home/home_state.dart';
import 'package:digikala_app/data/model/banner.dart';
import 'package:digikala_app/data/model/category.dart';
import 'package:digikala_app/data/model/product.dart';
import 'package:digikala_app/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../bloc/home/home_bloc.dart';
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _getHomeScreenContent(state, context);
          },
        ),
      ),
    );
  }

  Widget _getHomeScreenContent(HomeState state, BuildContext context) {
    if (state is HomeLoadingState) {
      return const Center(
        child: LoadingAnimation(),
      );
    } else if (state is HomeRequestSuccessState) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(HomeGetInitialData());
        },
        child: CustomScrollView(
          slivers: [
            const SearchBox(),
            state.bannerEither.fold(
              (exceptionMessage) =>
                  SliverToBoxAdapter(child: Text(exceptionMessage)),
              (listBanners) {
                return _getBanners(listBanners);
              },
            ),
            _getCategoryListTitle(),
            state.categoryEither.fold(
              (exceptionMessage) =>
                  SliverToBoxAdapter(child: Text(exceptionMessage)),
              (categoryList) => _getCategoryList(categoryList),
            ),
            _getBestSellerTitle(),
            state.bestSellerProductEither.fold(
              (exceptionMesssage) =>
                  SliverToBoxAdapter(child: Text(exceptionMesssage)),
              (productList) => _getBestSellerProduct(productList),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            _getMostViewedTitle(),
            state.hottestProductEither.fold(
              (errorMessage) => SliverToBoxAdapter(child: Text(errorMessage)),
              (productList) {
                return _getMostViewedProduct(productList);
              },
            ),
            const SliverPadding(padding: EdgeInsets.symmetric(vertical: 12)),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('خطایی در دریافت اطلاعات بوجود آمده است!'),
      );
    }
  }

  SliverToBoxAdapter _getMostViewedProduct(List<Product> productList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 210,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? const EdgeInsets.only(left: 10, right: 40)
                    : const EdgeInsets.symmetric(horizontal: 10),
                child: ProductItem(product: productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _getMostViewedTitle() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(
          children: [
            Image(image: AssetImage('assets/images/icon_left_categroy.png')),
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
              style: TextStyle(fontFamily: 'SB', color: CustomColors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBestSellerProduct(List<Product> productList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 210,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? const EdgeInsets.only(left: 10, right: 40)
                    : const EdgeInsets.symmetric(horizontal: 10),
                child: ProductItem(
                  product: productList[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _getBestSellerTitle() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(children: [
          Image(image: AssetImage('assets/images/icon_left_categroy.png')),
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
            style: TextStyle(fontFamily: 'SB', color: CustomColors.grey),
          ),
        ]),
      ),
    );
  }

  SliverToBoxAdapter _getCategoryListTitle() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Text(
          'دسته بندی',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontFamily: 'SB', color: CustomColors.grey),
        ),
      ),
    );
  }

  SliverToBoxAdapter _getCategoryList(List<Category> catergoryList) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 85,
        child: CategoryList(
          categoryList: catergoryList,
        ),
      ),
    );
  }

  Widget _getBanners(List<BannerHome> bannerList) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: BannerSlider(bannerList),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categoryList,
  });
  final List<Category> categoryList;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(left: 10, right: 40)
                : const EdgeInsets.symmetric(horizontal: 10),
            child: CategoryItemChip(
              category: categoryList[index],
            ),
          );
        },
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
                image: AssetImage('assets/images/icon_apple_blue.png'),
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
    );
  }
}
