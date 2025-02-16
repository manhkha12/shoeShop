import 'package:flutter/material.dart';
import 'package:shoe_store/features/signup/component/sign_up_header.dart';
import 'package:shoe_store/features/signup/component/signup_footer.dart';
import 'package:shoe_store/features/signup/component/signup_form.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.shoebackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              SignUpHeader(),
              SignUpForm(),
              SignUpFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
