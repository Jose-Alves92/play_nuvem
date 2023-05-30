import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'tv_tabbar_controller.dart';
import 'tv_tabbar_state.dart';
import 'widgets/category_widget.dart';


class TvTabBar extends StatefulWidget {
  const TvTabBar({
    Key? key,
  }) : super(key: key);

  @override
  State<TvTabBar> createState() => _TvTabBarState();
}

class _TvTabBarState extends State<TvTabBar> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvTabBarController>().fetchTvShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TvTabBarController>();
    final state = controller.state;

      if (state is TvTabBarLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvTabBarErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(' Ocorreu o seguinte erro: ${state.message}'),
              ),
            );
          } else if (state is TvTabBarSuccessState) {
            return ListView(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              bottom: 10,
              right: 0,
            ),
            shrinkWrap: true,
            children: [
              CategoryWidget(
                titleGenre: 'Ação e Aventura',
                listMedias: state.tvShowsCategories['ActionAdventure']!,
                mediaType: 'tv',
              ),
              const SizedBox(height: 10),
              CategoryWidget(
                titleGenre: 'Animação',
                listMedias: state.tvShowsCategories['Animation']!,
                mediaType: 'tv',
              ),
            const SizedBox(height: 10),
              CategoryWidget(
                titleGenre: 'Comédia',
                listMedias: state.tvShowsCategories['Comedy']!,
                mediaType: 'tv',
              ),
              const SizedBox(height: 10),
              CategoryWidget(
                titleGenre: 'Crime',
                listMedias: state.tvShowsCategories['Crime']!,
                mediaType: 'tv',
              ),
              const SizedBox(height: 10),
              CategoryWidget(
                titleGenre: 'Drama',
                listMedias: state.tvShowsCategories['Drama']!,
                mediaType: 'tv',
              ),
               const SizedBox(height: 10),
              CategoryWidget(
                titleGenre: 'Família',
                listMedias: state.tvShowsCategories['Family']!,
                mediaType: 'tv',
              ),
               const SizedBox(height: 10),
              CategoryWidget(
                titleGenre: 'Ficção Científica & Fantasia ',
                listMedias: state.tvShowsCategories['Sci-Fi & Fantasy']!,
                mediaType: 'tv',
              ),
            ],
          );} else {
            return const SizedBox();
          }

  }
}
