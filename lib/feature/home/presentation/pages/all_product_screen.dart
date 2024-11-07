import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/feature/home/presentation/widgets/product_listview_item.dart';
import 'package:khoyout/generated/l10n.dart';

import '../../../../core/helpers/product_type.dart';
import '../../../../core/routing/routes.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../data/models/products_model.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).products),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          return CustomScrollView(
            slivers: [
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductListViewItem(
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
                    ),
                    childCount: cubit.products.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ))
            ],
          );
        },
      ),
    );
  }
}
