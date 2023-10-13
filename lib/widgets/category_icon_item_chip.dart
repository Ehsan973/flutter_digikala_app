import 'package:flutter/material.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: ShapeDecoration(
            shadows: const [
              BoxShadow(
                color: Colors.amber,
                blurRadius: 25,
                spreadRadius: -12,
                offset: Offset(0, 15),
              )
            ],
            color: Colors.amber,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: const Icon(
            Icons.mouse,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'همه',
          style: TextStyle(
            fontFamily: 'SB',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
