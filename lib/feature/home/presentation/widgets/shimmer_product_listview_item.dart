import 'package:flutter/material.dart';

import '../../../../core/widgets/shimmer_loading_items.dart';

class ShimmerProductListviewItem extends StatelessWidget {
  const ShimmerProductListviewItem({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height/3,
        child: ListView.separated(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
          itemBuilder: (context, index) =>  ShimmerItem(
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}