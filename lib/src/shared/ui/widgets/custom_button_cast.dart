import 'package:flutter/material.dart';

class CustomButtonCast extends StatelessWidget {
  const CustomButtonCast({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return const ModuleBottomCast();
          },
        );
      },
      icon: const Icon(Icons.cast),
    );
  }
}

class ModuleBottomCast extends StatelessWidget {
  const ModuleBottomCast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: 80,
      child: const Text(
        'Nenhum conexão disponível!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }
}
