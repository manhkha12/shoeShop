import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoe_store/features/home_page/home_page_screen.dart';
import 'dart:async';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/localization/localizations.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appBarHeight,
      child: Row(
        children: [
          Assets.images.user.image(width: 40),
          const SizedBox(
            width: 12,
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Greeting(),
                AppText(
                  'Manh Kha',
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
          const _BellNotification(),
        ],
      ),
    );
  }
}

class BoxIcon extends StatelessWidget {
  final Color color;
  final Widget icon;
  const BoxIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Center(child: icon),
    );
  }
}

class _BellNotification extends StatelessWidget {
  const _BellNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Assets.icons.bell.svg(height: 20),
        Positioned(
          top: -2,
          right: 0,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.textError,
            ),
          ),
        )
      ],
    );
  }
}

class _Greeting extends StatefulWidget {
  const _Greeting({Key? key}) : super(key: key);

  @override
  State<_Greeting> createState() => __GreetingState();
}

class __GreetingState extends State<_Greeting> {
  Timer? _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppText(
      _currentTime.greetingKey.tr(),
      fontSize: 12,
    );
  }
}
