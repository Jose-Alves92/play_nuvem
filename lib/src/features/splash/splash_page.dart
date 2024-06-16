import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/splash/splash_controller.dart';
import 'package:play_nuvem/src/features/splash/splash_state.dart';
import 'package:play_nuvem/src/shared/locator/locator_services.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 

  var controller = getIt.get<SplashController>();

  @override
  void initState() {
    super.initState();
    controller.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('PlayNuvem', style: AppTextStyle.titleLarge, textAlign: TextAlign.center),
          ListenableBuilder(
              listenable: controller,
              builder: (context, child) {
                if (controller.state is SplashLoading) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                         height: 20,
                      ),
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Carregando dados...')
                    ],
                  );
                } else {
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.popAndPushNamed(context, AppRoutes.HOME_PAGE);
                  });
                  return const SizedBox();
                }
              },
            ),
        ],
      ),
    );
  }
}
