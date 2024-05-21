import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/media_details/media_details_page.dart';
import 'package:play_nuvem/src/features/splash_screen/splash_screen.dart';


import '../shared/ui/theme/app_theme.dart';
import 'home/home_bottom_bar.dart';
import '../shared/utils/app_routes.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayNuvem',
      theme: AppTheme.appTheme,
      
      initialRoute: AppRoutes.SPLASH_SCREEN,
      routes: {
        AppRoutes.SPLASH_SCREEN: (context) => const SplashScreen(),
        AppRoutes.HOME_PAGE: (context) => const HomeBottomBar(),
        AppRoutes.MEDIA_DETAILS_PAGE: (context) => const MediaDetailsPage(),
      },
    );
  }
}
