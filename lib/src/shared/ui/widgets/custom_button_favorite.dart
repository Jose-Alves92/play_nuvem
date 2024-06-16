import 'package:flutter/material.dart';

class CustomButtonFavorite extends StatelessWidget {
  const CustomButtonFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        
      },
      icon: const Icon(
        Icons.favorite_border_rounded,
      ),
    );
  }
}
