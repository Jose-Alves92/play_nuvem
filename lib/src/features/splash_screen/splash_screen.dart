import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/utils/app_routes.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({ super.key });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  future() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, AppRoutes.HOME_PAGE);
    });
  }

  @override
  void initState() {
    super.initState();
    future();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           backgroundColor: AppColors.primaryColor,
           body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('PlayNuvem', style: AppTextStyle.titleLarge),
              Image.network('/assets/icons/icon_play_nuvem_branco.png',
              scale: 1.5,
              ),
            ],
           ),
       );
  }
}