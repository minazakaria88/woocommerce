import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:khoyout/core/api_helper/woocommerce_api.dart';
import 'package:khoyout/core/helpers/lang_cubit/lang_cubit.dart';
import 'package:khoyout/feature/home/data/repositories/home_repo.dart';
import 'package:khoyout/feature/home/data/repositories/home_repo_impl.dart';
import 'package:khoyout/feature/more/presentation/manager/customer_cubit/create_customer_cubit.dart';
import 'package:khoyout/feature/more/presentation/manager/history_cubit/orders_history_cubit.dart';

import 'feature/home/presentation/manager/home_cubit.dart';
import 'feature/more/data/repositories/more_repo.dart';
import 'feature/more/data/repositories/more_repo_impl.dart';

final s1 = GetIt.instance;

void setupServiceLocator() {

  s1.registerFactory(() => HomeCubit(homeRepo: s1()));
  s1.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(apiHelper: s1()));

  s1.registerLazySingleton(() => ApiHelper(dio: s1()));

  s1.registerLazySingleton(() => Dio());

  s1.registerFactory(()=>OrdersHistoryCubit(moreRepo: s1()));

  s1.registerLazySingleton<MoreRepo>(() => MoreRepoImpl(apiHelper: s1()));

  s1.registerFactory(()=>LangCubit());

  s1.registerFactory(() => CreateCustomerCubit(moreRepo: s1()));

}