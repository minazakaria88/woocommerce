import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/feature/more/presentation/manager/customer_cubit/create_customer_cubit.dart';
import 'package:khoyout/feature/more/presentation/manager/customer_cubit/create_customer_state.dart';
import '../../../../core/widgets/my_text_form_filed.dart';
import '../../../../generated/l10n.dart';
import 'create_customer_button.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    passwordController.dispose();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).createCustomer),
        ),
        body: BlocConsumer<CreateCustomerCubit, CreateCustomerState>(
          listener: (context, state) {
            if (state is CreateCustomerErrorState) {
              showSnackBarF(context: context, text: state.error);

            }
            if (state is CreateCustomerSuccessState) {
               context.pop();
              showSnackBarF(context: context, text: S.of(context).LoggedIn);

            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<CreateCustomerCubit>(context);
            return SingleChildScrollView(
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
                            MyTextFormField(
                              controller: passwordController,
                              label: S.of(context).password,
                              prefixIcon: Icons.password,
                              valid: (String value) {
                                if (value.isEmpty) {
                                  return S.of(context).passwordMustNotBeEmpty;
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
                                        return S
                                            .of(context)
                                            .addressMustNotBeEmpty;
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
                            const SizedBox(
                              height: 20,
                            ),
                            state is CreateCustomerLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : CreateCustomerButton(
                                    formKey: _formKey,
                                    firstNameController: firstNameController,
                                    addressController: addressController,
                                    cityController: cityController,
                                    lastNameController: lastNameController,
                                    phoneController: phoneController,
                                    zipController: zipController,
                                    passwordController: passwordController,
                                    emailController: emailController,
                                    cubit: cubit),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ));
  }
}


