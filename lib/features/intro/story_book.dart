import 'package:shoe_store/app_config.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/localization/translate_extension.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/widgets/app_layout.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/app_text_form_field.dart';
import 'package:shoe_store/shared/widgets/buttons/buttons.dart';
import 'package:shoe_store/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class StoryBookScreen extends StatelessWidget {
  const StoryBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appBar: CustomAppBar(
        title: 'Storybook',
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Assets.icons.settings.svg(width: 18),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('spend_category.education'.tr()),
            AppText('Running: ${GetIt.I<AppConfig>().appEnv}'),
            const SizedBox(height: 10),
            AppButton(label: 'Login', onPressed: () {}),
            const SizedBox(height: 10),
            const AppButton(label: 'Login', onPressed: null),
            const SizedBox(height: 10),
            AppButton.outline(label: 'Login', onPressed: () {}),
            const SizedBox(height: 10),
            const AppButton.outline(label: 'Login', onPressed: null),
            const SizedBox(height: 10),
            AppTextFormField(
              hintText: 'Please enter username',
            ),
            const SizedBox(height: 10),
            AppTextFormField(
              hintText: 'Please enter password',
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Show loading',
              onPressed: () {
                context.showLoadingDialog();
                Future.delayed(const Duration(seconds: 5)).then(
                  (value) => context.hideLoadingDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
