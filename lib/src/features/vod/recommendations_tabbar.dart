// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/vod/recommendations_controller.dart';
import 'package:play_nuvem/src/features/vod/recommendations_state.dart';
import 'package:provider/provider.dart';

import 'widgets/category_widget.dart';

class RecommendationsTabBar extends StatefulWidget {
  const RecommendationsTabBar({super.key});

  @override
  State<RecommendationsTabBar> createState() => _RecommendationsTabBarState();
}

class _RecommendationsTabBarState extends State<RecommendationsTabBar> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecommendationsController>().fetchRecommendations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recommendationsController = context.watch<RecommendationsController>();
    final state = recommendationsController.state;
    if (state is RecommendationsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is RecommendationsErrorState) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(' Ocorreu o seguinte erro'),
        ),
      );
    } else if(state is RecommendationsSuccessState) {
      var listMedias = state.recommendationsCategories;
      return RefreshIndicator(
        onRefresh: () => recommendationsController.fetchRecommendations(),
        child: ListView(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            bottom: 10,
            right: 0,
          ),
          shrinkWrap: true,
          children: [
            CategoryWidget(
              titleGenre: 'Em Tendências',
              listMedias: listMedias['allTrending']!,
            ),
            const SizedBox(height: 10),
            CategoryWidget(
              titleGenre: 'Séries em Tendências',
              listMedias: listMedias['tvTrending']!,
            ),
            const SizedBox(height: 10),
            CategoryWidget(
              titleGenre: 'Filmes em Tendências',
              listMedias: listMedias['moviesTrending']!,
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
