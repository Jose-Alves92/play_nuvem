import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/home/home_page.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';


class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _indexBottomItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indexBottomItem,
        children:  [
          HomePage(),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: AppColors.backgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _indexBottomItem,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            activeIcon: Icon(Icons.home, color: AppColors.primaryColor),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud, color: Colors.white),
            activeIcon: Icon(Icons.cloud, color: AppColors.primaryColor),
            label: 'Filmes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.white),
            activeIcon: Icon(Icons.favorite, color: AppColors.primaryColor),
            label: 'Series',
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
