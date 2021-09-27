import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:task_todo/layout/cubit/cubitB.dart';
import 'package:task_todo/layout/shop_app/cubit/cubit.dart';
import 'package:task_todo/layout/social_app/social_cubit.dart';
import 'package:task_todo/layout/social_app/social_layout.dart';
import 'package:task_todo/modules/shop_app/on_boarding/onboarding_screen.dart';
import 'package:task_todo/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'file:///E:/api%20news%20app/TODO-main/lib/layout/shop_app/shop_layout.dart';
import 'package:task_todo/shared/cubit/cubit.dart';
import 'package:task_todo/shared/cubit/cubitStates.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';
import 'package:task_todo/shared/network/remote/dio_helper.dart';
import 'package:task_todo/shared/styles/themes.dart';
import 'layout/cubit/bloc_observer.dart';
import 'layout/newsapp/news_app_layout.dart';
import 'modules/shop_app/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  bool isDark =true ; //CasheHelper.getData('isDark');
  uid = CasheHelper.getData('uid');
//  bool onBoarding = CasheHelper.getData('onBoarding');
//  token = CasheHelper.getData('token');
  Widget widget = OnBordingScreen();
  // if(onBoarding!=null){
  //   if(token!=null)widget = ShopLayout();
  //   else  widget = ShopLoginScreen();
  // }
  widget = uid!=null ? SocialLayout(): SocialLoginScreen();
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  bool isDark;
  Widget startWidget;

  MyApp({this.isDark,this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AppCubit()..ChangeThemeMode(fromSharedPreferences: isDark),
        ),
        BlocProvider(
          create: (context) =>
          SocialCubit()..getUserData()..getPosts()
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.light
                  : ThemeMode.dark,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: startWidget
          );
        },
      ),
    );
  }
}

