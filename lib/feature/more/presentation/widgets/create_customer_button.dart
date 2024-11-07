import 'package:flutter/material.dart';
import 'package:khoyout/generated/l10n.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../cart/data/models/create_order_model.dart';
import '../../data/models/create_customer_model.dart';
import '../manager/customer_cubit/create_customer_cubit.dart';

class CreateCustomerButton extends StatelessWidget {
  const CreateCustomerButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.firstNameController,
    required this.addressController,
    required this.cityController,
    required this.lastNameController,
    required this.phoneController,
    required this.zipController,
    required this.passwordController,
    required this.emailController,
    required this.cubit,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController firstNameController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController zipController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final CreateCustomerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyButton(
        text: S.of(context).CreateAccount,
        onTap: () {
          if (_formKey.currentState!.validate()) {
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

            CreateCustomerModel model = CreateCustomerModel(
              password: passwordController.text,
              email: emailController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              billing: billing,
              shipping: shipping,
            );
            cubit.createCustomer(model);
          }
        },
      ),
    );
  }
}