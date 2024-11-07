import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/generated/l10n.dart';

import '../../../../core/routing/routes.dart';
import '../widgets/category_gird_view_item.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).categories),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          return CustomScrollView(
            slivers: [
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => InkWell(
                      onTap: () {
                        cubit.getProductsByCategory(cubit.categories[index].id);
                        context.pushNamed(Routes.allProductByCategoryScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryGridViewItem(
                            width: width,
                            height: height,
                            cubit: cubit,
                            index: index),
                      ),
                    ),
                    childCount: cubit.categories.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                  ))
            ],
          );
        },
      ),
    );
  }
}
