import 'package:flutter/material.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/helpers/product_type.dart';
import 'package:khoyout/core/routing/routes.dart';
import 'package:khoyout/feature/cart/data/models/cart_item_model.dart';
import 'package:khoyout/feature/home/data/models/products_model.dart';
import 'package:khoyout/feature/home/presentation/widgets/product_listview_item.dart';

import '../manager/home_cubit.dart';

class ProductsListview extends StatelessWidget {
  const ProductsListview({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ProductListViewItem(
              width: width,
              height: height,
              model: cubit.products[index],
              index: index,
              onTap: (){
                if(cubit.products[index].type==checkProductType(ProductType.variable)) {
                  cubit.getProductVariants(cubit.products[index].id);
                }
                ProductModel productModel=cubit.products[index];
                context.pushNamed(Routes.productDetail,arguments: CartItemModel(productModel: productModel.copyWith()),);
              },
              addToCart: (){
                if(cubit.products[index].type==checkProductType(ProductType.variable))
                  {
                    cubit.getProductVariants(cubit.products[index].id);
                    ProductModel productModel=cubit.products[index];
                    context.pushNamed(Routes.productDetail,arguments: CartItemModel(productModel: productModel.copyWith()),);
                  }
                else
                  {
                    cubit.addToCart(CartItemModel(productModel: cubit.products[index]));
                  }
              },
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
            itemCount: cubit.products.length,
          ),
        ),
      ),
    );
  }
}