import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/vod/movies_tabbar_controller.dart';

import 'package:provider/provider.dart';

import 'movies_tabbar_state.dart';
import 'widgets/category_widget.dart';

class MoviesTabBar extends StatefulWidget {
  const MoviesTabBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MoviesTabBar> createState() => _MoviesTabBarState();
}

class _MoviesTabBarState extends State<MoviesTabBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviesTabBarController>().fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MoviesTabBarController>();
    final state = controller.state;
    print('build foi chamado');
    if (state is MoviesTabBarLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MoviesTabBarErrorState) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(' Ocorreu o seguinte erro: ${state.message}'),
        ),
      );
    } else if (state is MoviesTabBarSuccessState) {
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
            listMedias: state.moviesCategories['ActionAdventure']!,
            mediaType: 'movie',
          ),
          const SizedBox(height: 10),
          CategoryWidget(
            titleGenre: 'Animação',
            listMedias: state.moviesCategories['Animation']!,
            mediaType: 'movie',
          ),
          const SizedBox(height: 10),
          CategoryWidget(
            titleGenre: 'Comedia',
            listMedias: state.moviesCategories['Comedy']!,
            mediaType: 'movie',
          ),
          const SizedBox(height: 10),
          CategoryWidget(
            titleGenre: 'Crime',
            listMedias: state.moviesCategories['Crime']!,
            mediaType: 'movie',
          ),
          const SizedBox(height: 10),
          CategoryWidget(
            titleGenre: 'Drama',
            listMedias: state.moviesCategories['Drama']!,
            mediaType: 'movie',
          ),
          const SizedBox(height: 10),
          CategoryWidget(
            titleGenre: 'Família',
            listMedias: state.moviesCategories['Family']!,
            mediaType: 'movie',
          ),
          const SizedBox(height: 10),
          CategoryWidget(
            titleGenre: 'Fantasia',
            listMedias: state.moviesCategories['Fantasy']!,
            mediaType: 'movie',
          ),
          const SizedBox(height: 10),
          CategoryWidget(
            titleGenre: 'Terror e Suspense',
            listMedias: state.moviesCategories['HorrorMystery']!,
            mediaType: 'movie',
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
