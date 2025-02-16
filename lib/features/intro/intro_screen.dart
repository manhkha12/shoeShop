import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/localization/translate_extension.dart';
import 'package:shoe_store/routes.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/buttons/app_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.shoebackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.shoe_background.image(width: 150, height: 150),
                SizedBox(
                  height: 10,
                ),
                AppText(
                  'intro.intro_4.title'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                AppText(
                  'intro.intro_4.description'.tr(),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 100,
                ),
                AppButton(
                  label: 'intro.btn_start'.tr(),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.login);
                  },
                  primaryColor: context.colors.onlineColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
