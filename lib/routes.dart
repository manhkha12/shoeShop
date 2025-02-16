
import 'package:shoe_store/features/intro/intro_screen.dart';
import 'package:shoe_store/features/intro/story_book.dart';
import 'package:shoe_store/features/login/login_screen.dart';

import 'package:shoe_store/features/main_screen.dart';
import 'package:shoe_store/features/signup/sign_up_screen.dart';

import 'package:shoe_store/shared/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/intro/splash_screen.dart';

class RouteName {
  static const String splash = '/';
  static const String storyBook = '/story-book';
  static const String intro = '/intro';
  static const String main = '/main';
  static const String login = '/login';
  static const String signup = '/signup';

  // static const String mainTuLam ='/mainTuLam';
  
}

RouteFactory onGenerateRoutes() {
  return (RouteSettings settings) {
    if (settings.name == RouteName.splash) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SplashScreen(),
      );
    }
    if (settings.name == RouteName.storyBook) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const StoryBookScreen(),
      );
    }
    if (settings.name == RouteName.intro) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const IntroScreen(),
      );
    }
    // if (settings.name == RouteName.main) {
    //   return MaterialPageRoute(
    //     settings: settings,
    //     builder: (context) => const MainScreen(),
    //   );
    // }
    // if (settings.name == RouteName.mainTuLam) {
    //   return MaterialPageRoute(
    //     settings: settings,
    //     builder: (context) => const HomePageTuLam(),
    //   );
    // }


    if (settings.name == RouteName.login) {
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
                create: (context) => LoginCubit(isSignup: false),
                child: const LoginScreen(),
              ));
    }

    if (settings.name == RouteName.signup) {
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
                create: (context) => LoginCubit(isSignup: true),
                child: const SignUpScreen(),
              ));
    }
    

    return MaterialPageRoute(
      builder: (_) => Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Text('No route found: ${settings.name}'),
        ),
      ),
    );
  };
}
