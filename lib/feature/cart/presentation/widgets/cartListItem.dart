import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khoyout/feature/cart/presentation/widgets/quantity_control_button.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../home/presentation/manager/home_cubit.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
  });

  final double width;
  final double height;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width / 5,
                            height: height / 7,
                            child: CachedNetworkImage(
                              imageUrl: cubit
                                  .cartList[index].productModel.images[0].src,
                              placeholder: (context, url) =>
                                  Image.asset(AppImages.loading),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.cartList[index].productModel.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    cubit.cartList[index].productModel.price,
                                    style: const TextStyle(fontSize: 20,color: AppColors.primaryColor),
                                  ),
                                ]),
                          ),
                          QuantityControlButton(
                              heroTag: '1',
                              icon: Icons.remove,
                              onPressed: () {
                                cubit.decreaseQuantity(index);
                              },
                              color: AppColors.brown),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              cubit.cartList[index].quantity.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                          QuantityControlButton(
                              heroTag: '2',
                              icon: Icons.add,
                              onPressed: () {
                                cubit.increaseQuantity(index);
                              },
                              color: AppColors.orange),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.removeFromCart(index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.secondaryColor,
                    ),
                  )
                ],
              ),
          childCount: cubit.cartList.length),
    );
  }
}
