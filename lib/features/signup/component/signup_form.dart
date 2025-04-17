import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/localization/localizations.dart';
import 'package:shoe_store/routes.dart';
import 'package:shoe_store/shared/cubits/login_cubit/login_cubit.dart';
import 'package:shoe_store/shared/cubits/login_cubit/login_state.dart';
import 'package:shoe_store/shared/cubits/signup_cubit/signup_cubit.dart';
import 'package:shoe_store/shared/cubits/signup_cubit/signup_state.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';
import 'package:shoe_store/shared/utils/validate_form.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/app_text_form_field.dart';
import 'package:shoe_store/shared/widgets/buttons/app_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();


  
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: context.width,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.colors.disabledInputBorder,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'signup.email'.tr(),
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
                          context.read<SignupCubit>().emailChanged(value);
                        },
                        fillColor: context.colors.ligthGrey,
                        hintText: 'login.input_email'.tr(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppText(
                        'signup.name_express'.tr(),
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      AppTextFormField(
                        hintText: 'signup.input_name_express'.tr(),
                        autovalidateMode: AutovalidateMode.disabled,
                        validator: (value) {
                          return Validation.validateUserName(value);
                        },
                        onChanged: (value) {
                          context.read<SignupCubit>().userNameChanged(value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppText(
                        'signup.password'.tr(),
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      AppTextFormField(
                        hintText: 'login.input_password'.tr(),
                        autovalidateMode: AutovalidateMode.disabled,
                        controller: passwordController,
                        validator: (value) {
                          return Validation.validatePass(value);
                        },
                        onChanged: (value) {
                          context.read<SignupCubit>().passwordChanged(value);
                        },
                        fillColor: context.colors.ligthGrey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppText(
                        'signup.re_input_pass'.tr(),
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      AppTextFormField(
                        hintText: 'signup.re_input_pass'.tr(),
                        validator: (value) {
                          return Validation.validateRePass(
                              value, passwordController.text);
                        },
                        onChanged: (value) {
                          context.read<SignupCubit>().rePassChanged(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            BlocListener<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state.signupSuccess) {
                Navigator.pushNamed(context, RouteName.login);
              }
            },
            child:
            BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
              return AppButton(
                label: 'signup.title'.tr(),
                onPressed: state.isValid
                    ? () {
                        var valid = _formKey.currentState!.validate();
                        if (!valid) {
                          context.read<SignupCubit>().register();
                        }
                      }
                    : null,
                textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                primaryColor: context.colors.onlineColor,
              );
            }),),
          ],
        ));
  }
}
