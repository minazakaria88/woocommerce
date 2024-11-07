import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/routing/routes.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/core/widgets/my_button.dart';
import 'package:khoyout/core/widgets/my_text_form_filed.dart';
import 'package:khoyout/feature/more/presentation/manager/customer_cubit/create_customer_cubit.dart';
import 'package:khoyout/feature/more/presentation/manager/customer_cubit/create_customer_state.dart';
import 'package:khoyout/generated/l10n.dart';

import '../../../../core/helpers/cache_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Login),
      ),
      body: BlocConsumer<CreateCustomerCubit, CreateCustomerState>(
        listener: (context, state) {
          if (state is LoginCustomerSuccessState) {
            showSnackBarF(context: context, text: S.of(context).LoggedIn);
          } else if (state is LoginCustomerErrorState) {
            showSnackBarF(context: context, text: state.error);
          } else if (state is LoginCustomerSuccessEmptyState) {
            showSnackBarF(context: context, text: S.of(context).InvalidEmail);
          }
        },
        builder: (context, state) {
          return CacheHelper.getData(key: CacheHelperKeys.createCustomer) !=
                  null
              ? const LoadingWidget()
              : Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFormField(
                        controller: controller,
                        label: S.of(context).email,
                        prefixIcon: Icons.email,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return S.of(context).emailMustNotBeEmpty;
                          }
                        },
                        textInputType: TextInputType.emailAddress,
                      ),
                      state is LoginCustomerLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ))
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 12),
                              child: MyButton(
                                text: S.of(context).Login,
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<CreateCustomerCubit>(
                                            context)
                                        .login(controller.text.trim());
                                  }
                                },
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                S.of(context).Donthaveanaccount,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(Routes.createCustomer);
                              },
                              child: Text(
                                S.of(context).SignUp,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              S.of(context).YouArealreadyloggedin,
              style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            10.width,
            const Icon(Icons.verified, color: AppColors.primaryColor),
          ],
        ),
      );
  }
}
