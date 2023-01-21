import 'package:flutter/material.dart';
import 'package:play_nuvem/components/category_component.dart';
import 'package:play_nuvem/controllers/midia_controller.dart';
import 'package:provider/provider.dart';

class RecommendationsTabBarComponent extends StatelessWidget {
  const RecommendationsTabBarComponent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final MidiaController midiaController = Provider.of(context, listen: false);
    return FutureBuilder(
      future: midiaController.fetchRecommendations(),
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
                listMidiasByGenres: midiaController.moviesTrending,
                midiaType: 'movie',
              ),
              CategoryComponent(
                titleGenre: 'Séries em Tendências',
                listMidiasByGenres: midiaController.tvTrending,
                midiaType: 'tv',
              ),
            ],
            );
      },
    );
  }
}


