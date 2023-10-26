import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/data/repository/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
            SliverToBoxAdapter(
              child: ElevatedButton(
                  onPressed: () async {
                    var repository = CategoryRepository();
                    var either = await repository.getCategories();
                    either.fold((l) {
                      print(l);
                    }, (r) {
                      r.forEach((element) {
                        print(element.title);
                      });
                    });
                  },
                  child: Text('Get data')),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
