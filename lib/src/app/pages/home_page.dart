import 'package:flutter/material.dart';

import 'favorites_page.dart';
import 'nuvem_page.dart';
import 'profile_page.dart';
import 'vod_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexBottomItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indexBottomItem,
        children: const [
          VodPage(),
          NuvemPage(),
          FavoritesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indexBottomItem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.slow_motion_video),
            label: 'Vod',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Nuvem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (idx) {
          setState(() {
            _indexBottomItem = idx;
          });
        },
      ),
    );
  }
}
