import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khoyout/core/helpers/cache_helper.dart';
import 'package:khoyout/core/helpers/lang_cubit/lang_cubit.dart';
import 'package:khoyout/core/helpers/lang_cubit/lang_state.dart';
import 'package:khoyout/core/routing/app_routes.dart';
import 'package:khoyout/core/utils/app_theme.dart';
import 'generated/l10n.dart';
import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await CacheHelper.init();
  runApp(
      DevicePreview(enabled: false, builder: (context) => const WooCommerce()));
}

class WooCommerce extends StatelessWidget {
  const WooCommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => di.s1<LangCubit>(),
          child: BlocBuilder<LangCubit, LangState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<LangCubit>(context);
              return MaterialApp(
                theme: appTheme(),
                locale: Locale(cubit.defaultLanguage),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                navigatorKey: NavigationService.navigatorKey,
                debugShowCheckedModeBanner: false,
                title: '',
                onGenerateRoute: AppRoutes.onGeneratedRoute,
              );
            },
          ),
        );
      },
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
