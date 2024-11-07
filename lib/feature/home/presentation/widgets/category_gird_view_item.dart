import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../manager/home_cubit.dart';

class CategoryGridViewItem extends StatelessWidget {
  const CategoryGridViewItem({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
    required this.index,
  });

  final double width;
  final double height;
  final HomeCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width / 3,
            height: height / 4.5,
            child: CachedNetworkImage(
              imageUrl: cubit.categories[index].images==null ? AppImages.noImage:cubit.categories[index].images!.src,
              placeholder: (context, url) => Image.asset(AppImages.loading),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            cubit.categories[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
