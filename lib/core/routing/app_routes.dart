import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/routing/routes.dart';
import 'package:khoyout/feature/cart/data/models/cart_item_model.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/pages/all_categories_screen.dart';
import 'package:khoyout/feature/home/presentation/pages/all_product_screen.dart';
import 'package:khoyout/feature/home/presentation/pages/home_screen.dart';
import 'package:khoyout/feature/home/presentation/pages/pay_screen.dart';
import 'package:khoyout/feature/home/presentation/pages/paymob_screen.dart';
import 'package:khoyout/feature/home/presentation/pages/product_details.dart';
import 'package:khoyout/feature/home/presentation/pages/products_by_category_screen.dart';
import 'package:khoyout/feature/more/presentation/manager/customer_cubit/create_customer_cubit.dart';
import 'package:khoyout/feature/more/presentation/manager/history_cubit/orders_history_cubit.dart';
import 'package:khoyout/feature/more/presentation/widgets/create_customer_screen.dart';
import 'package:khoyout/feature/more/presentation/widgets/login_screen.dart';
import 'package:khoyout/injection.dart' as di;

import '../../feature/more/presentation/widgets/oders_history_screen.dart';

class AppRoutes {
  static var cubit = di.s1<HomeCubit>();
  static var createCustomerCubit = di.s1<CreateCustomerCubit>();
  static Route onGeneratedRoute(RouteSettings routeSettings) {
    var arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) => cubit
                  ..getProducts()
                  ..getCategories()),
            BlocProvider(create: (context) => createCustomerCubit),
          ], child: const HomeScreen()),
        );
      case Routes.productDetail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: cubit,
              child: ProductDetails(
                cartItemModel: arguments as CartItemModel,
              )),
        );
      case Routes.pay:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: cubit, child: const PaymentScreen()),
        );
      case Routes.allCategoryScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: cubit, child: const AllCategoriesScreen()),
        );
      case Routes.allProductByCategoryScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: cubit, child: const AllProductByCategoryScreen()),
        );
      case Routes.allProductScreen:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: cubit, child: const AllProductScreen()),
        );
      case Routes.orderHistory:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => di.s1<OrdersHistoryCubit>()..getHistory(),
              child: const OrdersHistoryScreen()),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: createCustomerCubit,
              child: const LoginScreen()),
        );
      case Routes.createCustomer:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: createCustomerCubit, child: const CreateCustomerScreen()),
        );
      case Routes.paymobScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: cubit,
              child: PayMobScreen(
                clientSecret: arguments as String,

              )),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('No route '),
            ),
          ),
        );
    }
  }
}
