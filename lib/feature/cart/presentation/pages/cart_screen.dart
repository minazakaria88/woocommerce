import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/routing/routes.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/generated/l10n.dart';

import '../widgets/cartListItem.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return cubit.cartList.isEmpty
            ? Center(child: Text(S.of(context).cartIsEmpty))
            : Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        CartListItem(
                            width: width, height: height, cubit: cubit),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor),
                      child: MaterialButton(
                          onPressed: () {
                            context.pushNamed(Routes.pay);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).checkOut,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Text(
                                  '${cubit.total} EGP',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
      },
    );
  }
}
