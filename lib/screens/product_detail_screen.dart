import 'dart:ui';

import 'package:digikala_app/bloc/basket/basket_bloc.dart';
import 'package:digikala_app/bloc/basket/basket_event.dart';
import 'package:digikala_app/bloc/product/product_bloc.dart';
import 'package:digikala_app/bloc/product/product_event.dart';
import 'package:digikala_app/bloc/product/product_state.dart';
import 'package:digikala_app/data/model/product.dart';
import 'package:digikala_app/data/model/product_image.dart';
import 'package:digikala_app/data/model/product_property.dart';
import 'package:digikala_app/data/model/product_variant.dart';
import 'package:digikala_app/data/model/variant.dart';
import 'package:digikala_app/data/model/variant_type.dart';
import 'package:digikala_app/widgets/cached_image.dart';
import 'package:digikala_app/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(ProductInitializEvent(
            widget.product.id, widget.product.categoryId));
        return bloc;
      },
      child: Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(
                child: LoadingAnimation(),
              );
            }
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
                  if (state is ProductResponseState) ...{
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/images/icon_apple_blue.png'),
                              ),
                              Expanded(
                                child: Text(
                                  state.productCategoryEither.fold(
                                    (l) => 'دسته بندی',
                                    (productCategory) =>
                                        productCategory.title ?? 'دسته بندی',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 16,
                                    color: CustomColors.blue,
                                  ),
                                ),
                              ),
                              const Image(
                                image:
                                    AssetImage('assets/images/icon_back.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  },
                  if (state is ProductResponseState) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          widget.product.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (state is ProductResponseState) ...[
                    state.productImageEither.fold(
                      (errorMessage) =>
                          SliverToBoxAdapter(child: Text(errorMessage)),
                      (productImageList) {
                        return GalleryWidget(
                          imageList: productImageList,
                          defaultProductThumbnail: widget.product.thumbnail,
                        );
                      },
                    )
                  ],
                  if (state is ProductResponseState) ...[
                    state.productVariantEither.fold(
                      (l) => SliverToBoxAdapter(
                        child: Text(l),
                      ),
                      (productVariantList) {
                        return VariantContainerGenerator(
                            productVariantList: productVariantList);
                      },
                    ),
                  ],
                  // _getStorageOptions(),
                  if (state is ProductResponseState) ...[
                    state.productPropertiesEither.fold(
                      (errorMessage) =>
                          SliverToBoxAdapter(child: Text(errorMessage)),
                      (productProperties) {
                        return ProductProperties(
                          productProperties: productProperties,
                        );
                      },
                    ),
                  ],
                  if (state is ProductResponseState) ...[
                    ProductDescription(
                      productDescription: widget.product.description,
                    ),
                  ],
                  if (state is ProductResponseState) ...[
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                  ],
                  if (state is ProductResponseState) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const PriceTagButton(),
                            AddToBasketButton(
                              product: widget.product,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _getStorageOptions() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }
}

class ProductProperties extends StatefulWidget {
  final List<Property> productProperties;
  const ProductProperties({
    super.key,
    required this.productProperties,
  });

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
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
                        image:
                            AssetImage('assets/images/icon_left_categroy.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              padding: const EdgeInsets.all(12),
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
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.productProperties.length,
                    itemBuilder: (context, index) {
                      var property = widget.productProperties[index];
                      return Row(
                        children: [
                          Flexible(
                            child: Text(
                              ' ${property.title!} : ${property.value!}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'sm',
                                height: 1.8,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  final String productDescription;
  const ProductDescription({
    super.key,
    required this.productDescription,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
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
                        image:
                            AssetImage('assets/images/icon_left_categroy.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
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
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    widget.productDescription,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;

  const VariantContainerGenerator(
      {super.key, required this.productVariantList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant: productVariant)
            }
          }
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  final ProductVariant productVariant;
  const VariantGeneratorChild({super.key, required this.productVariant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: const TextStyle(
              fontFamily: 'SM',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(variantList: productVariant.variantList),
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(storageVariants: productVariant.variantList),
          }
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final List<ProductImage> imageList;
  final String? defaultProductThumbnail;
  const GalleryWidget(
      {super.key,
      required this.imageList,
      required this.defaultProductThumbnail});

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
                        imageUrl: (widget.imageList.isEmpty)
                            ? widget.defaultProductThumbnail
                            : widget.imageList[_selectedPoductImage].imageUrl,
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
            if (widget.imageList.isNotEmpty) ...{
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
              ),
            } else ...{
              const SizedBox(
                height: 50,
              ),
            }
          ],
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  final Product product;
  const AddToBasketButton({super.key, required this.product});

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
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: GestureDetector(
              onTap: () {
                context.read<ProductBloc>().add(ProductAddToBasket(product));
                context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
              },
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
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'افزودن به سبد خرید',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SB',
                      ),
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
                            fontSize: 10,
                            fontFamily: 'SM',
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '324000000',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SM',
                            ),
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
                            fontSize: 10,
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

class ColorVariantList extends StatefulWidget {
  final List<Variant> variantList;
  const ColorVariantList({super.key, required this.variantList});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantList.length,
          itemBuilder: (context, index) {
            String hexColor = 'ff${widget.variantList[index].value}';
            Color itemColor = Color(int.parse(hexColor, radix: 16));
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: (_selectedIndex == index)
                      ? Border.all(
                          width: 1,
                          color: CustomColors.blueIndicator,
                          strokeAlign: BorderSide.strokeAlignOutside)
                      : Border.all(width: 2, color: Colors.white),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  final List<Variant> storageVariants;
  const StorageVariantList({super.key, required this.storageVariants});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                height: 25,
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: _selectedIndex == index
                      ? Border.all(width: 2, color: CustomColors.blueIndicator)
                      : Border.all(width: 1, color: CustomColors.grey),
                ),
                child: Center(
                  child: Text(
                    widget.storageVariants[index].value!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'SB',
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
