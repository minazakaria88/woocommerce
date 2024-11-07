import 'package:dio/dio.dart';
import 'package:khoyout/core/payment_getway/payment_api_endpoint.dart';
import 'package:khoyout/feature/home/data/models/pay_model.dart';
import 'package:khoyout/feature/more/data/models/create_customer_model.dart';


abstract class PaymentGetaway {}

class PaymobManager extends PaymentGetaway {

   Future<String> getClientSecret({required double amount,required PayModel customerModel}) async {
     try
         {
           Dio dio=Dio(
             BaseOptions(
               baseUrl: 'https://accept.paymob.com/',
               receiveDataWhenStatusError: true,
             ),
           );
           dio.options.headers={
             'Authorization':'Token ${PaymentApiEndpoints.secretKey}',
             'Content-Type':'application/json',
           };
           var response=await dio.post(PaymentApiEndpoints.intentionUrl,data: {
             "amount": amount*100,
             "currency": "EGP",
             "payment_methods": [
               4722068
             ],
             "items": [

             ],
             "billing_data": {
               "first_name": customerModel.firstName,
               "last_name": customerModel.lastName,
               "street": customerModel.address,
               "phone_number": customerModel.phone,
               "country": "EGP",
               "email": customerModel.email,
             },
           });
           return response.data['client_secret'];
         }catch(e)
     {
       rethrow;
     }
   }


}


