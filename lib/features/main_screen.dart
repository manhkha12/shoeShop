import 'package:shoe_store/features/caterogy/caterogy_page_screen.dart';

import 'package:shoe_store/features/home_page/home_page_screen.dart';
import 'package:shoe_store/features/cart/cart_detail.dart';
import 'package:shoe_store/features/order/component/order_detail.dart';
import 'package:shoe_store/features/setting/setting_page_screen.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/widgets/bottom_navigation/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bottomNavKey = GlobalKey<BottomNavigationState>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigation(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      items: [
        BottomNavigationItem(
          icon: Assets.icons.home.path,
          page: const HomePageScreen(),
        ),
        BottomNavigationItem(
          icon: Assets.icons.shoppingCart.path,
          page: const OrderDetail(),
        ),
        BottomNavigationItem(
          icon: Assets.icons.other.path,
          page: const CaterogyScreen(),
        ),
        BottomNavigationItem(
          icon: Assets.icons.settings.path,
          page: const SettingScreen(),
        ),
      ],
      activeColor: context.colors.primaryColor,
    );
  }
}
