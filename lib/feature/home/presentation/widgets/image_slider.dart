import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../manager/home_cubit.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CarouselSlider(
          items: cubit.images.map((e) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(e,fit: BoxFit.cover,))).toList(),
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          )
      ),
    );
  }
}