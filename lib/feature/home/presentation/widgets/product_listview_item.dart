import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khoyout/core/utils/app_images.dart';
import 'package:khoyout/feature/home/data/models/products_model.dart';

import '../../../../core/utils/app_colors.dart';

class ProductListViewItem extends StatelessWidget {
  const ProductListViewItem({super.key, required this.width, required this.height, required this.index, required this.onTap, required this.addToCart, required this.model});
  final double width;
  final double height;
  final int index;
  final ProductModel model;
  final Function onTap;
  final Function addToCart;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: SizedBox(
        width:width/3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  SizedBox(
                    width: width/3,
                    height: height/5,
                    child: Hero(
                      tag: model.id,
                      child:
                      CachedNetworkImage(
                        imageUrl: model.images.isNotEmpty ? model.images[0].src:AppImages.noImage,
                        placeholder: (context, url) => Image.asset(AppImages.loading),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      addToCart();
                    },
                    heroTag: null,
                    mini: true,
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(Icons.add,color: Colors.white,),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.price.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if(model.salePrice!='')
                  Text(
                    model.regularPrice.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                      decorationColor: AppColors.primaryColor,
                      decorationStyle: TextDecorationStyle.wavy
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
