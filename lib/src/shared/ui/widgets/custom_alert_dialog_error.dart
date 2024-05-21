// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_style.dart';

class CustomAlertDialogError extends StatelessWidget {
  const CustomAlertDialogError({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    throw AlertDialog(
      backgroundColor: AppColors.secondaryColor,
      icon: const Icon(Icons.error_outlined),
      iconColor: Colors.red,
      title: const Text('Ocorreu um erro!'),
      titleTextStyle: AppTextStyle.titleMedium.copyWith(fontSize: 20),
      content: Text(error,overflow: TextOverflow.ellipsis, maxLines: 5, softWrap: true),
      contentTextStyle: AppTextStyle.bodySmall,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'OK',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        )
      ],
    );
  }
}
