import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "package:page_transition/page_transition.dart";
import 'package:untitled/Network/end_points.dart';
import 'package:untitled/Network/local/cache_helper.dart';
import 'package:untitled/Network/remote/dio_helper.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/bloc/splashCubit/splash_cubit.dart';
import 'package:untitled/modules/login_screen.dart';
import 'package:untitled/modules/shop_layout/layout_screen.dart';
import 'package:untitled/shared/theme.dart';

import 'bloc/loginAuthenticationCubit/user_cubit.dart';
import 'constants.dart';
import 'helper/bloc_observer.dart';
import 'modules/on_boarding.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.Init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  //CacheHelper.deleteAllData();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: onboardingkey) ?? false;
  token = CacheHelper.getData(key: tokenkey) ?? "";
  print(token);
  if (onBoarding != false) {
    if (token != "") {
      widget = const LayoutScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnboardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit()..GetUserData(),
        ),
        BlocProvider(
          create: (context) => LayoutCubit()
            ..GetHomeData()
            ..GetCategoryData()
            ..GetFavouriteData()
          ..GetCartData()..GetQuestionData()
          ,
        ),
      ],
      child: MaterialApp(
        home: AnimatedSplashScreen(
          animationDuration: const Duration(milliseconds: 500),
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.white,
          splash:const SizedBox(
            width: 274,
            height: 100,
            child:  Image(
              image: AssetImage("assets/images/splash.png"),
            ),
          ),
          nextScreen: widget,
        ),

        debugShowCheckedModeBanner: false,
        theme: theme,
        themeMode: ThemeMode.light,

      ),
    );
  }
}
