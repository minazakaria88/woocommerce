import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/payment_getway/payment_api_endpoint.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/helpers/cache_helper.dart';
import '../../../../generated/l10n.dart';
import '../manager/home_cubit.dart';

class PayMobScreen extends StatefulWidget {
  const PayMobScreen({super.key, required this.clientSecret, });
  final String clientSecret;
  @override
  State<PayMobScreen> createState() => _PayMobScreenState();
}

class _PayMobScreenState extends State<PayMobScreen> {

  WebViewController controller = WebViewController();
  @override
  initState() {
    controller..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if(url.contains('success=true')) {
              context.pop();
              List<String> orderIds=CacheHelper.getListData(key: CacheHelperKeys.ordersHistory);
              BlocProvider.of<HomeCubit>(context).clearData();
              BlocProvider.of<HomeCubit>(context).editOrderStatus(int.parse(orderIds[orderIds.length-1]), {'set_paid':true});
              showSnackBarF(context: context, text:  S.of(context).orderSuccess);
            }
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://accept.paymob.com/unifiedcheckout/?publicKey=${PaymentApiEndpoints.publicKey}&clientSecret=${widget.clientSecret}'));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(

      onPopInvoked: (pop){

      },
      child: Scaffold(
        appBar: AppBar(
          leading:  IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              BlocProvider.of<HomeCubit>(context).clearData();
              context.pop();
            },
          ),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
