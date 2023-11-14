import 'package:digikala_app/bloc/categoryProduct/category_product_bloc.dart';
import 'package:digikala_app/bloc/categoryProduct/category_product_event.dart';
import 'package:digikala_app/bloc/categoryProduct/category_product_state.dart';
import 'package:digikala_app/data/model/category.dart';
import 'package:digikala_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen({super.key, required this.category});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColors.backgroundScreenColor,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
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
                            image:
                                AssetImage('assets/images/icon_apple_blue.png'),
                          ),
                          Expanded(
                            child: Text(
                              widget.category.title!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
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
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                },
                if (state is CategoryProductResponseSuccessState) ...{
                  state.productListByCategoryEither.fold(
                    (errorMessage) => SliverToBoxAdapter(
                      child: Text(errorMessage),
                    ),
                    (productList) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                ProductItem(product: productList[index]),
                            childCount: productList.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 2.7,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                          ),
                        ),
                      );
                    },
                  ),
                }
              ],
            ),
          ),
        );
      },
    );
  }
}
