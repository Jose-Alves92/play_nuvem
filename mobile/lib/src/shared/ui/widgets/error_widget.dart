import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/ui/styles/images_app.dart';

class ErrorPageWidget extends StatelessWidget {

  const ErrorPageWidget({ super.key });

   @override
   Widget build(BuildContext context) {
       return SizedBox(
        width: double.infinity,
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagesApp.imgError,
            scale: 5,
            ),
            const SizedBox(
               height: 10,
            ),
            const Text('Não há dados disponível', style: AppTextStyle.bodySmall),
          ],
         ),
       );
  }
}