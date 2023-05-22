import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/media_controller.dart';
import 'category_component.dart';

class RecommendationsTabBarComponent extends StatelessWidget {
  const RecommendationsTabBarComponent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Provider.of(context, listen: false);
    return FutureBuilder(
      future: mediaController.fetchRecommendations(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError) {
          return Center(child: Text(' Ocorreu o seguinte erro: ${snapshot.hasError}'),);
        }
        return ListView(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              bottom: 10,
              right: 0,
            ),
            shrinkWrap: true,
            children: [
              CategoryComponent(
                titleGenre: 'Filmes em Tendências',
                listMediasByGenres: mediaController.moviesTrending,
                mediaType: 'movie',
              ),
              CategoryComponent(
                titleGenre: 'Séries em Tendências',
                listMediasByGenres: mediaController.tvTrending,
                mediaType: 'tv',
              ),
            ],
            );
      },
    );
  }
}


