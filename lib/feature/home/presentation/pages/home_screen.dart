import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/generated/l10n.dart';


import '../../../../core/utils/app_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      S.of(context).Home,
      S.of(context).Search,
      S.of(context).Cart,
      S.of(context).More,
    ];
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected =
                  !connectivity.contains(ConnectivityResult.none);
              if (connected) {
                if(cubit.products.isEmpty) {
                  cubit.getCategories();
                  cubit.getProducts();
                }
                return buildScaffold(cubit, context,titles);
              } else {
                return Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(AppImages.noInternet),
                      const SizedBox(
                        height: 30,
                      ),
                       Center(child: Text(S.of(context).noInternet)),
                    ],
                  ),
                );
              }
            },
            child: const Center(child: CircularProgressIndicator()));
        //buildScaffold(cubit, context);
      },
    );
  }

  Scaffold buildScaffold(HomeCubit cubit, BuildContext context,List<String> titles) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[cubit.currentIndex]),
      ),
      body: cubit.screens[cubit.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        onTap: (index) {
          cubit.changeBottomNav(index);
        },
        currentIndex: cubit.currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: S.of(context).Home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search), label: S.of(context).Search),
          BottomNavigationBarItem(
              icon: Badge(
                backgroundColor: AppColors.orange,
                label: Text(cubit.cartList.length.toString()),
                isLabelVisible: cubit.cartList.isNotEmpty ? true : false,
                child: const Icon(Icons.add_shopping_cart),
              ),
              label: S.of(context).Cart),
          BottomNavigationBarItem(
              icon: const Icon(Icons.menu), label: S.of(context).More),
        ],
      ),
    );
  }
}
