import 'package:digikala_app/data/model/category.dart';
import 'package:digikala_app/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class CategoryItemChip extends StatelessWidget {
  CategoryItemChip({
    super.key,
    required this.category,
  });
  Category category;

  @override
  Widget build(BuildContext context) {
    int categoryColor = int.parse('ff${category.color}', radix: 16);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: Color(categoryColor),
                blurRadius: 25,
                spreadRadius: -12,
                offset: const Offset(0, 15),
              )
            ],
            color: Color(categoryColor),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CachedImage(
              imageUrl: category.icon,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          category.title ?? 'محصول',
          style: const TextStyle(
            fontFamily: 'SB',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
