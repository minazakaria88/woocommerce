import 'package:flutter/material.dart';
import 'package:khoyout/core/helpers/extenction.dart';

import '../../../../core/routing/routes.dart';
import '../manager/home_cubit.dart';
import 'category_gird_view_item.dart';

class CategoryGridview extends StatelessWidget {
  const CategoryGridview({
    super.key,
    required this.cubit,
    required this.width,
    required this.height,
  });

  final HomeCubit cubit;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => InkWell(
          onTap: () {
            cubit.getProductsByCategory(cubit.categories[index].id);
            context.pushNamed(Routes.allProductByCategoryScreen);
          },
          child: CategoryGridViewItem(
              width: width, height: height, cubit: cubit, index: index),
        ),
        childCount: cubit.categories.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.45,
      ),
    );
  }
}
