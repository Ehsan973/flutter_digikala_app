import 'package:digikala_app/bloc/category/category_bloc.dart';
import 'package:digikala_app/bloc/category/category_event.dart';
import 'package:digikala_app/bloc/category/category_state.dart';
import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/data/model/category.dart';
import 'package:digikala_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryListRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
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
                        image: AssetImage('assets/images/icon_apple_blue.png'),
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
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryInitialState) {
                  return const SliverToBoxAdapter(child: Text(''));
                } else if (state is CategoryLoadingState) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is CategoryResponseState) {
                  return state.response.fold((l) {
                    return SliverToBoxAdapter(child: Text(l));
                  }, (r) {
                    return CategoryList(categoryList: r);
                  });
                }
                return const SliverToBoxAdapter(child: Text('Error!'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Category>? categoryList;
  const CategoryList({
    super.key,
    required this.categoryList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              CachedImage(imageUrl: categoryList?[index].thumbnail),
          childCount: categoryList?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
