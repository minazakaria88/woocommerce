import 'package:flutter/material.dart';

import '../../../../core/widgets/shimmer_loading_items.dart';

class CategoryShimmerGridview extends StatelessWidget {
  const CategoryShimmerGridview({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) =>
            ShimmerItem(width: width, height: height),
        childCount: 10,
      ),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.45,
      ),
    );
  }
}
