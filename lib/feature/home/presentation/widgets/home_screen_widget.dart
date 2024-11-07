import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/cache_helper.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/routing/routes.dart';
import 'package:khoyout/core/utils/app_colors.dart';

import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/widgets/home_text_widget.dart';
import 'package:khoyout/feature/home/presentation/widgets/product_listview.dart';
import 'package:khoyout/feature/home/presentation/widgets/shimmer_product_listview_item.dart';

import 'package:khoyout/generated/l10n.dart';

import '../manager/home_state.dart';
import 'category__shimmer_gridview.dart';

import 'category_gridview.dart';
import 'image_slider.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  void initState() {
    if (CacheHelper.getData(key: CacheHelperKeys.createCustomer) != null ) {
      if(BlocProvider.of<HomeCubit>(context).customerModel==null)
        {
          BlocProvider.of<HomeCubit>(context).getCustomerData(
              CacheHelper.getData(key: CacheHelperKeys.createCustomer));
        }
    }
    else
      {
        BlocProvider.of<HomeCubit>(context).customerModel=null;
      }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              if (cubit.customerModel != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'welcome , ${cubit.customerModel!.firstName}',
                      style: const TextStyle(
                          color: AppColors.primaryColor, fontSize: 22,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              ImageSlider(cubit: cubit),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              HomeTextWidget(
                text: S.of(context).products,
                onTap: () {
                  context.pushNamed(Routes.allProductScreen);
                },
                textButton: S.of(context).ShowAll,
              ),
              cubit.products.isNotEmpty
                  ? ProductsListview(
                      height: height,
                      width: width,
                      cubit: cubit,
                    )
                  : ShimmerProductListviewItem(height: height, width: width),
              HomeTextWidget(
                text: S.of(context).categories,
                onTap: () {
                  context.pushNamed(Routes.allCategoryScreen);
                },
                textButton: S.of(context).ShowAll,
              ),
              cubit.categories.isNotEmpty
                  ? CategoryGridview(cubit: cubit, width: width, height: height)
                  : CategoryShimmerGridview(width: width, height: height)
            ],
          ),
        );
      },
    );
  }
}
