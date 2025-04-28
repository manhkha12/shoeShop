import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/localization/localizations.dart';
import 'package:shoe_store/routes.dart';
import 'package:shoe_store/shared/cubits/login_cubit/login_cubit.dart';
import 'package:shoe_store/shared/cubits/login_cubit/login_state.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';
import 'package:shoe_store/shared/utils/validate_form.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/app_text_form_field.dart';
import 'package:shoe_store/shared/widgets/buttons/app_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: context.width,
            height: 200,
            decoration: BoxDecoration(
                color: context.colors.disabledInputBorder,
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'login.input_email'.tr(),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    AppTextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (value) {
                        return Validation.validateEmail(value);
                      },
                      onChanged: (value) {
                        context.read<LoginCubit>().emailChanged(value);
                      },
                      fillColor: context.colors.ligthGrey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText(
                      'login.input_password'.tr(),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    AppTextFormField(
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (value) {
                        return Validation.validatePass(value);
                      },
                      onChanged: (value) {
                        context.read<LoginCubit>().passwordChanged(value);
                      },
                      fillColor: context.colors.ligthGrey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AppText(
              'login.fogot_pass'.tr(),
              color: context.colors.black,
              textDecoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocListener<LoginCubit, LoginState>(
            listener: (_, state) {
              print("Login Success State: ${state.loginSuccess}");
              if (state.loginSuccess) {
                if (state.userRole == "admin") {
                  Navigator.pushReplacementNamed(
                      context, RouteName.adminDashboard);
                } else {
                  Navigator.pushReplacementNamed(context, RouteName.main);
                }
              }
            },
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return AppButton(
                  onPressed: state.valid && !state.isLoading
                      ? () async {
                          var valid = _formKey.currentState!.validate();
                          if (valid) {
                            await context.read<LoginCubit>().login();
                          }
                        }
                      : null,
                  label: state.isLoading ? 'Loading...' : 'login.title'.tr(),
                  textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                  primaryColor: context.colors.onlineColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
