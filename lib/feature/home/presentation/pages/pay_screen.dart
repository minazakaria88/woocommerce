import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/helpers/cache_helper.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/payment_getway/payment.dart';
import 'package:khoyout/core/routing/routes.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/core/widgets/loader_widget.dart';
import 'package:khoyout/core/widgets/my_text_form_filed.dart';
import 'package:khoyout/feature/home/data/models/pay_model.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/generated/l10n.dart';
import '../widgets/pay_button_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> paymentOptions = [
    'Cash on Delivery',
    'Direct Bank Transfer',
    'Check Payments',
  ];
  final List<String> paymentMethods = [
    'cod',
    'bacs',
    'cheque',
  ];
  String selectedPaymentOption = '';
  String selectedPaymentMethod = '';
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    phoneController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    checkCustomerModel();
    super.initState();
  }

  void checkCustomerModel() async {
    if (CacheHelper.getData(key: CacheHelperKeys.createCustomer) != null) {
      if (BlocProvider.of<HomeCubit>(context).customerModel == null) {
        await BlocProvider.of<HomeCubit>(context).getCustomerData(
            CacheHelper.getData(key: CacheHelperKeys.createCustomer));
        setData();
      } else {
        setData();
      }
    }
  }

  void setData() {
    var model = BlocProvider.of<HomeCubit>(context).customerModel;
    emailController.text = model!.email;
    firstNameController.text = model.firstName;
    lastNameController.text = model.lastName;
    addressController.text = model.billing.address;
    cityController.text = model.billing.city;
    zipController.text = model.billing.postalCode;
    phoneController.text = model.billing.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).payment),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) async {
          if (state is OrderSuccessState) {
            if (selectedPaymentOption == paymentOptions[2]) {
              PayModel model = PayModel(
                phone: phoneController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                address: addressController.text,
                email: emailController.text,
              );
              String secretKey = await PaymobManager().getClientSecret(
                  amount: BlocProvider.of<HomeCubit>(context).total,
                  customerModel: model);
              if (context.mounted) {
                context.pushReplacementNamed(Routes.paymobScreen,
                    arguments: secretKey);
              }
            } else {
              context.pop();
              BlocProvider.of<HomeCubit>(context).clearData();
              showSnackBarF(context: context, text: S.of(context).orderSuccess);
            }
          } else if (state is OrderErrorState) {
            showSnackBarF(context: context, text: S.of(context).pleaseTryAgain);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            S.of(context).BillingDetails,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFormField(
                          controller: firstNameController,
                          label: S.of(context).firstname,
                          prefixIcon: Icons.person,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return S.of(context).firstNameMustNotBeEmpty;
                            }
                          },
                          textInputType: TextInputType.name,
                        ),
                        MyTextFormField(
                          controller: lastNameController,
                          label: S.of(context).lastname,
                          prefixIcon: Icons.person,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return S.of(context).lastNameMustNotBeEmpty;
                            }
                          },
                          textInputType: TextInputType.name,
                        ),
                        MyTextFormField(
                          controller: emailController,
                          label: S.of(context).email,
                          prefixIcon: Icons.email,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return S.of(context).emailMustNotBeEmpty;
                            }
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormField(
                                controller: cityController,
                                label: S.of(context).city,
                                prefixIcon: Icons.location_city,
                                valid: (String value) {
                                  if (value.isEmpty) {
                                    return S.of(context).cityMustNotBeEmpty;
                                  }
                                },
                                textInputType: TextInputType.text,
                              ),
                            ),
                            Expanded(
                              child: MyTextFormField(
                                controller: addressController,
                                label: S.of(context).address,
                                prefixIcon: Icons.location_on_outlined,
                                valid: (String value) {
                                  if (value.isEmpty) {
                                    return S.of(context).addressMustNotBeEmpty;
                                  }
                                },
                                textInputType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                        MyTextFormField(
                          controller: zipController,
                          label: S.of(context).zipCode,
                          prefixIcon: Icons.local_post_office_sharp,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return S.of(context).zipCodeMustNotBeEmpty;
                            }
                          },
                          textInputType: TextInputType.number,
                        ),
                        MyTextFormField(
                          controller: phoneController,
                          label: S.of(context).phone,
                          prefixIcon: Icons.phone,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return S.of(context).phoneMustNotBeEmpty;
                            }
                          },
                          textInputType: TextInputType.phone,
                        ),
                        paymentOptionsWidgets(),
                        state is OrderLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PayButtonScreen(
                                    formKey: _formKey,
                                    customerId: CacheHelper.getData(
                                        key: CacheHelperKeys.createCustomer),
                                    paymentMethod: selectedPaymentMethod,
                                    paymentMethodTitle: selectedPaymentOption,
                                    firstNameController: firstNameController,
                                    addressController: addressController,
                                    cityController: cityController,
                                    lastNameController: lastNameController,
                                    phoneController: phoneController,
                                    zipController: zipController,
                                    cubit: cubit,
                                    emailController: emailController),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is UserLoadingState || state is OrderSuccessState)
                const LoaderWidget(),
            ],
          );
        },
      ),
    );
  }

  Padding paymentOptionsWidgets() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.4),
            child: RadioListTile(
              activeColor: AppColors.primaryColor,
              title: Text(paymentOptions[0]),
              value: paymentOptions[0],
              groupValue: selectedPaymentOption,
              onChanged: (String? value) {
                setState(() {
                  selectedPaymentOption = value!;
                  selectedPaymentMethod = paymentMethods[0];
                });
              },
            ),
          ),
          if (selectedPaymentOption == paymentOptions[0])
            AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText('pay with cash upon delivery'),
                ]),
          10.height,
          Container(
            color: Colors.grey.withOpacity(0.4),
            child: RadioListTile(
              activeColor: AppColors.primaryColor,
              title: Text(paymentOptions[1]),
              value: paymentOptions[1],
              groupValue: selectedPaymentOption,
              onChanged: (String? value) {
                setState(() {
                  selectedPaymentOption = value!;
                  selectedPaymentMethod = paymentMethods[1];
                });
              },
            ),
          ),
          if (selectedPaymentOption == paymentOptions[1])
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: AnimatedTextKit(
                  repeatForever: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(
                        'make your payment directly into our bank account . please use your Order ID as a payment reference,YourOrder will not be shipped until the funds cleared in our account',
                        speed: const Duration(milliseconds: 12)),
                  ]),
            ),
          10.height,
          Container(
            color: Colors.grey.withOpacity(0.4),
            child: RadioListTile(
              activeColor: AppColors.primaryColor,
              title: Text(paymentOptions[2]),
              value: paymentOptions[2],
              groupValue: selectedPaymentOption,
              onChanged: (String? value) {
                setState(() {
                  selectedPaymentOption = value!;
                  selectedPaymentMethod = paymentMethods[2];
                });
              },
            ),
          ),
          if (selectedPaymentOption == paymentOptions[2])
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                  repeatForever: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText('check our payments',
                        speed: const Duration(milliseconds: 12)),
                  ]),
            ),
        ],
      ),
    );
  }

}
