import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/localization/translate_extension.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';

class SettingHeader extends StatefulWidget {
  final bool value;
  const SettingHeader({super.key, this.value = false});

  @override
  State<SettingHeader> createState() => _SettingHeaderState();
}

class _SettingHeaderState extends State<SettingHeader> {
  late bool _isDarkMode = false;
  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.value; // Gán giá trị ban đầu từ widget
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 180,
            width: context.width,
            decoration: BoxDecoration(
                color: context.colors.dimGrey,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'settings.account'.tr(),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BoxSetting(
                    title: 'settings.profile'.tr(),
                    icon: Assets.icons.arrowRight.svg(),
                    image: Assets.icons.profile.svg(),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BoxSetting(
                    title: 'settings.pass_and_security'.tr(),
                    icon: Assets.icons.arrowRight.svg(),
                    image: Assets.icons.lock.svg(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 235,
            width: context.width,
            decoration: BoxDecoration(
                color: context.colors.dimGrey,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'settings.title'.tr(),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BoxSetting(
                    title: 'settings.language'.tr(),
                    icon: Assets.icons.arrowRight.svg(),
                    image: Assets.icons.language.svg(),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BoxSetting(
                    title: 'settings.pass_and_security'.tr(),
                    icon: Assets.icons.arrowRight.svg(),
                    image: Assets.icons.bell.svg(),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colors.divider),
                            child: Center(
                              child: _isDarkMode
                                  ? Assets.icons.darkMode.svg(height: 25)
                                  : Assets.icons.lightMode.svg(),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: AppText(
                            _isDarkMode
                                ? 'settings.dark_mode'.tr()
                                : 'settings.light_mode'.tr(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: _isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              _isDarkMode = value;
                            });
                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoxSetting extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget image;
  final Function()? onTap;

  const BoxSetting(
      {super.key,
      required this.title,
      required this.icon,
      required this.image,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: context.colors.divider),
            child: Center(child: image),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: AppText(
              title,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.colors.divider),
            child: Center(child: icon),
          ),
        ],
      ),
    );
  }
}
