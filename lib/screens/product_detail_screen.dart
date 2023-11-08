import 'dart:ui';

import 'package:digikala_app/bloc/product/product_bloc.dart';
import 'package:digikala_app/bloc/product/product_event.dart';
import 'package:digikala_app/bloc/product/product_state.dart';
import 'package:digikala_app/data/model/product.dart';
import 'package:digikala_app/data/model/product_image.dart';
import 'package:digikala_app/data/model/product_variant.dart';
import 'package:digikala_app/data/model/variant.dart';
import 'package:digikala_app/data/model/variant_type.dart';
import 'package:digikala_app/data/repository/product_detail_repository.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key, required this.product});
  Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(ProductInitializEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductLoadingState) ...[
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
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
                              'دسته بندی',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16,
                                color: CustomColors.blue,
                              ),
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/images/icon_back.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      ' Se 2022 آیفون',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                if (state is ProductResponseState) ...[
                  state.productImageEither.fold(
                    (errorMessage) =>
                        SliverToBoxAdapter(child: Text(errorMessage)),
                    (productImageList) {
                      return GalleryWidget(imageList: productImageList);
                    },
                  )
                ],
                if (state is ProductResponseState) ...[
                  state.productVariantEither.fold(
                    (l) => SliverToBoxAdapter(
                      child: Text(l),
                    ),
                    (productVariantList) {
                      return VariantContainer(
                          productVariantList: productVariantList);
                    },
                  ),
                ],
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'انتخاب حافظه داخلی',
                          style: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 25,
                              margin: const EdgeInsets.only(left: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.grey,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '512',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'SB',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 25,
                              margin: const EdgeInsets.only(left: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.grey,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '256',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'SB',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 25,
                              margin: const EdgeInsets.only(left: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.grey,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '128',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'SB',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 46,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: CustomColors.grey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              'مشخصات فنی:',
                              style: TextStyle(
                                fontFamily: 'SM',
                              ),
                            ),
                            Spacer(),
                            Text(
                              'مشاهده',
                              style: TextStyle(
                                fontFamily: 'SB',
                                color: CustomColors.blue,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  'assets/images/icon_left_categroy.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 46,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: CustomColors.grey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Text(
                              'توضیحات محصول:',
                              style: TextStyle(
                                fontFamily: 'SM',
                              ),
                            ),
                            Spacer(),
                            Text(
                              'مشاهده',
                              style: TextStyle(
                                fontFamily: 'SB',
                                color: CustomColors.blue,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  'assets/images/icon_left_categroy.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 46,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: CustomColors.grey,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            const Text(
                              'نظرات کاربران:',
                              style: TextStyle(
                                fontFamily: 'SM',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 45,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 60,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '10+',
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
                            ),
                            const Spacer(),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                fontFamily: 'SB',
                                color: CustomColors.blue,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Image(
                              image: AssetImage(
                                  'assets/images/icon_left_categroy.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PriceTagButton(),
                        AddToBasketButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VariantContainer extends StatelessWidget {
  List<ProductVariant> productVariantList;

  VariantContainer({super.key, required this.productVariantList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              productVariantList[0].variantType.title!,
              style: const TextStyle(
                fontFamily: 'SM',
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ..._buildColorVariantOptions(productVariantList[0].variantList),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildColorVariantOptions(List<Variant> variantList) {
    List<Widget> colorWidgets = [];
    for (var colorVariant in variantList) {
      String hexColor = 'ff${colorVariant.value}';
      Color itemColor = Color(int.parse(hexColor, radix: 16));
      var item = Container(
        height: 26,
        width: 26,
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      );
      colorWidgets.add(item);
    }
    return colorWidgets;
  }
}

class GalleryWidget extends StatefulWidget {
  List<ProductImage> imageList;
  GalleryWidget({super.key, required this.imageList});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int _selectedPoductImage = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 284,
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Image(
                          image: AssetImage('assets/images/icon_star.png'),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '4.6',
                          style: TextStyle(fontFamily: 'SM', fontSize: 12),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: double.infinity,
                      child: CachedImage(
                        imageUrl:
                            widget.imageList[_selectedPoductImage].imageUrl,
                      ),
                    ),
                    const Spacer(),
                    const Image(
                      image: AssetImage(
                        'assets/images/icon_favorite_deactive.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: ListView.builder(
                  itemCount: widget.imageList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPoductImage = index;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            width: 1,
                            color: CustomColors.grey,
                          ),
                        ),
                        child: CachedImage(
                          imageUrl: widget.imageList[index].imageUrl,
                          radius: 10,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            IDetailProductRepository repository = locator.get();
            var response = await repository.getProductImage();
            response.fold((l) {}, (r) {
              r.forEach((element) {
                print(element.imageUrl);
              });
            });
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 53,
                width: 160,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'SB',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 53,
              width: 160,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'تومان',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'SM', fontSize: 12),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Column(
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
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
