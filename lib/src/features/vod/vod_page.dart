import 'package:flutter/material.dart';


import 'movies_tabbar.dart';
import 'recommendations_tabbar.dart';
import 'tv_tabbar.dart';




class VodPage extends StatefulWidget {
  const VodPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VodPage> createState() => _VodPageState();
}

class _VodPageState extends State<VodPage> {
    

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          //elevation: 0,
          title: const Text('PlayNuvem', style: TextStyle(fontSize: 26)),
          //centerTitle: true,
          actions: [
            IconButton(
              padding: const EdgeInsets.all(8.0),
              onPressed: () {},
              icon: const Icon(Icons.search),
              iconSize: 30,
            ),
           
          ],
          bottom: const TabBar(
            padding: EdgeInsets.all(5.0),
            isScrollable: true,
            tabs: [
              Text('Recomendações', style: TextStyle(fontSize: 15)),
              Text('Filmes', style: TextStyle(fontSize: 15)),
              Text('Séries', style: TextStyle(fontSize: 15)),
              //Text('Infantil'),
              //Text('Animes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RecommendationsTabBar(),
            MoviesTabBar(),
            TvTabBar(),
            //Center(child: Text('Infantil')),
            //Center(child: Text('Animes')),
          ],
        ),
      ),
    );
  }
}


