import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_system_app/layout/states.dart';
import 'package:hotel_system_app/modules/location_screen.dart';
import 'package:hotel_system_app/utils/bloc_observer.dart';

import 'layout/cubit.dart';
import 'modules/welcome_screen.dart';
import 'shared/network/cache_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? welcome=CacheHelper.getData(key: 'welcome');
  Widget screen;
  if (welcome!=null) {
      screen= LocationScreen();
    }else {
    screen= WelcomeScreen();
  }
  runApp( MyApp(
    welcomeScreen: welcome,
    screen: screen,
  ));
}

class MyApp extends StatelessWidget {
  bool? welcomeScreen;
  Widget screen;
  MyApp({
    required this.welcomeScreen,
    required this.screen,
  });// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contxet) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: screen, 
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
