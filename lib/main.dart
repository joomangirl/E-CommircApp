// @dart=2.9

// ignore_for_file: use_key_in_widget_constructors

import 'package:faster/modules/main_screen/main_screen.dart';
import 'package:faster/shared/bloc_observer.dart';
import 'package:faster/shared/network/Dio_Helper/dio_helper.dart';
import 'package:faster/shared/network/end_point.dart';
import 'package:faster/shared/network/local.dart';
import 'package:faster/shared/network/payment.dart';
import 'package:faster/styles/theme_data.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_layout/cubit/cubit.dart';
import 'home_layout/cubit/state.dart';

import 'landing_screen/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Cash_Helper.init();
  await StripeService.init();

  bool themMode = Cash_Helper.getData(key: 'them');
  TOKEN = Cash_Helper.getData(key: 'token');

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(themMode, TOKEN));
    },
    blocObserver: SimpleBlocObserver(),
  );
  DioHelper.init();
}

class MyApp extends StatelessWidget {
  final bool themMode;
  final String token;

  const MyApp(this.themMode, this.token);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => HomeCubit()
                ..mode(fromShared: themMode)
                ..getProductsData()
                //..getPopularPruducts()
                ..getOrdersData()
                ..getUserData()),
        ],
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (BuildContext context, HomeState state) {},
            builder: (BuildContext context, HomeState state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home:
                    token != null ? const Main_Screen() : const LandingScreen(),
                theme: Styles.themeData(
                    HomeCubit.get(context).isDarkTheme, context),
              );
            }));
  }
}
