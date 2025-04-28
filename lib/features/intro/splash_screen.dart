import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/features/intro/intro_screen.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/routes.dart';
import 'package:shoe_store/shared/cubits/app_cubit/app_cubit.dart';

import 'package:shoe_store/shared/extensions/build_context_extension.dart';

import 'package:flutter/material.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    // Chờ 3 giây rồi chuyển màn hình
      context.read<AppCubit>().checkAuthState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.shoebackground,
      body: BlocListener<AppCubit,AppState>(
        listener: (context,state) =>state.whenOrNull(
          authorized: (user) =>
              Navigator.of(context).pushReplacementNamed(RouteName.main),
          unAuthorized: () =>
              Navigator.of(context).pushReplacementNamed(RouteName.intro),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.shoe_shop
                  .svg(width: 100, height: 100, color: context.colors.black),
              SizedBox(height: 20),
              const AppText(
                "S'Store",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
