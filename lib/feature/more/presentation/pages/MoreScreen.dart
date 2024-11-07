import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/helpers/cache_helper.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/helpers/lang_cubit/lang_cubit.dart';
import 'package:khoyout/core/helpers/lang_cubit/lang_state.dart';
import 'package:khoyout/core/routing/routes.dart';
import 'package:khoyout/core/widgets/logout_dialog.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/generated/l10n.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/list_tile_more_screen_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        var cubit=BlocProvider.of<HomeCubit>(context);
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<LangCubit, LangState>(
                builder: (context, state) {
                  var cubit = BlocProvider.of<LangCubit>(context);
                  return ListTile(
                    onTap: () {
                      cubit.changeLanguage();
                    },
                    leading:
                    const Icon(Icons.language, color: AppColors.primaryColor),
                    title:
                    Text(cubit.defaultLanguage == 'ar' ? "اللغة العربية" : "English"),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: AppColors.orange),
                  );
                },
              ),
            ),
            spacing(),
            ListTileMoreScreenWidget(
              onTap: () {
                context.pushNamed(Routes.orderHistory);
              },
              title: S.of(context).ordersHistory,
              icon: Icons.history,
            ),
            spacing(),
            ListTileMoreScreenWidget(
              onTap: () {
                context.pushNamed(Routes.loginScreen);
              },
              title: S.of(context).CreateAccount,
              icon: Icons.person,
            ),
            spacing(),
            ListTileMoreScreenWidget(
              onTap: () {
                buildShowDialog(context,cubit);
              },
              title: S.of(context).Logout,
              icon: Icons.logout,
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context,cubit) {
    return showDialog(
      context: context,
      builder: (context) => LogOutDialog(
          color: Colors.teal,
          onTap: () {
            CacheHelper.removeData(key: CacheHelperKeys.createCustomer);
            cubit.customerModel=null;
            context.pop();
            showSnackBarF(context: context, text: S.of(context).logoutSuccessfully);
          }),
    );
  }

  Widget spacing() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 10,
      ),
    );
  }
}
