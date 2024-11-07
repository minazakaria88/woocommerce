import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/widgets/my_text_form_filed.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/generated/l10n.dart';
import '../../../../core/helpers/product_type.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../../home/data/models/products_model.dart';
import '../../../home/presentation/widgets/product_listview_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  controller: searchController,
                  label: S.of(context).Search,
                  prefixIcon: Icons.search,
                  valid: () {},
                  onChange: (String value) {
                    cubit.searchByCategoryName(value);
                  },
                  textInputType: TextInputType.text,
                ),
              ),
            ),
            cubit.productsByCategory.isNotEmpty &&
                    searchController.text.isNotEmpty
                ? SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductListViewItem(
                          width: width,
                          height: height,
                          model: cubit.productsByCategory[index],
                          index: index,
                          onTap: () {
                            if(cubit.productsByCategory[index].type==checkProductType(ProductType.variable)) {
                              cubit.getProductVariants(cubit.productsByCategory[index].id);
                            }
                            ProductModel productModel=cubit.productsByCategory[index];
                            context.pushNamed(
                              Routes.productDetail,
                              arguments: CartItemModel(
                                  productModel:
                                  productModel.copyWith()),
                            );
                          },
                          addToCart: () {
                            if(cubit.productsByCategory[index].type==checkProductType(ProductType.variable))
                            {
                              cubit.getProductVariants(cubit.productsByCategory[index].id);
                              ProductModel productModel=cubit.productsByCategory[index];
                              context.pushNamed(Routes.productDetail,arguments: CartItemModel(productModel: productModel.copyWith()),);
                            }
                            else
                            {
                              cubit.addToCart(CartItemModel(productModel: cubit.productsByCategory[index]));
                            }
                          },
                        ),
                      ),
                      childCount: cubit.productsByCategory.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ))
                : searchController.text.isNotEmpty
                    ?  SliverToBoxAdapter(
                        child: Center(
                          child: state is SearchByCategoryEmptyState? Text(S.of(context).emptyCategory):const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(child: SizedBox()),
          ],
        );
      },
    );
  }
}
