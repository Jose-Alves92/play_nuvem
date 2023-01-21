import 'package:flutter/material.dart';
import 'package:play_nuvem/components/movies_tabbar_component.dart';
import 'package:play_nuvem/components/recommendations_tabbar_component.dart';
import 'package:play_nuvem/controllers/midia_controller.dart';
import 'package:play_nuvem/data/category_data.dart';
import 'package:provider/provider.dart';

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
            IconButton(
              padding: const EdgeInsets.all(8.0),
              iconSize: 30,
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
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
            RecommendationsTabBarComponent(),
            MoviesTabBarComponent(),
            Center(child: Text('Séries')),
            //Center(child: Text('Infantil')),
            //Center(child: Text('Animes')),
          ],
        ),
      ),
    );
  }
}


