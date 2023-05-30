import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(8.0),
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 30,
          ),
         
        ],
      ),
    );
  }
}