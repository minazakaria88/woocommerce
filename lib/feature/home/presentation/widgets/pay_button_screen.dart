import 'package:flutter/material.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/generated/l10n.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../cart/data/models/create_order_model.dart';
import '../manager/home_cubit.dart';

class PayButtonScreen extends StatelessWidget {
  const PayButtonScreen({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.firstNameController,
    required this.addressController,
    required this.cityController,
    required this.lastNameController,
    required this.phoneController,
    required this.zipController,
    required this.cubit,
    required this.emailController,
    required this.paymentMethodTitle, required this.paymentMethod, required this.customerId,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  final TextEditingController firstNameController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController zipController;
  final HomeCubit cubit;
  final String paymentMethodTitle;
  final String paymentMethod;
  final TextEditingController emailController;
  final int ?customerId;
  @override
  Widget build(BuildContext context) {
    return MyButton(
        text: S.of(context).placeOrder,
        onTap: () {
          if (_formKey.currentState!.validate()) {
           if(paymentMethodTitle!='')
             {
               Billing billing = Billing(
                 firstName: firstNameController.text,
                 address: addressController.text,
                 city: cityController.text,
                 lastName: lastNameController.text,
                 phone: phoneController.text,
                 postalCode: zipController.text,
               );

               Shipping shipping = Shipping(
                 firstName: firstNameController.text,
                 address: addressController.text,
                 city: cityController.text,
                 lastName: lastNameController.text,
                 phone: phoneController.text,
                 postalCode: zipController.text,
               );

               List<LineItems> lineItems = [];
               for (var item in cubit.cartList) {
                 lineItems.add(
                   LineItems(
                     productId: item.productModel.id,
                     quantity: item.quantity,
                     variationId: item.variantId,
                   ),
                 );
               }
               CreateOrderModel createOrderModel = CreateOrderModel(
                   billing: billing,
                   customerId: customerId,
                   shipping: shipping,
                   setPaid: false,
                   paymentMethod: paymentMethod,
                   email: emailController.text,
                   paymentMethodTitle: paymentMethodTitle,
                   lineItems: lineItems);

               cubit.makeOrder(createOrderModel.toJson());
             }
           else
             {
               showSnackBarF(context: context, text: S.of(context).pleaseSelectPaymentMethod);
             }
          }
        });
  }
}
