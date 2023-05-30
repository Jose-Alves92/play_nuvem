import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/vod/movie_details_state.dart';
import 'package:provider/provider.dart';

import '../../shared/models/media_model.dart';
import '../../shared/models/reproduction_items.dart';
import 'movie_details_controller.dart';
import 'widgets/video_player_widget.dart';



class DetailsMoviePage extends StatefulWidget {
  final Media movie;
  const DetailsMoviePage({
    super.key,
    required this.movie,
  });

  @override
  State<DetailsMoviePage> createState() => _DetailsMoviePageState();
}

class _DetailsMoviePageState extends State<DetailsMoviePage> {
 

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieDetailsController>().loadMovies(widget.movie.id.toString());
    });
  }

  int selectedItemCloud = 0;

  void updateUrl(int index) {
    setState(() {
      selectedItemCloud = index;
    });
  }


  _showCloudBottomSheet(BuildContext context, List<ReproductionItems> listReproductions) {
    final controller = context.read<MovieDetailsController>();
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return listReproductions.isEmpty
            ? Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                height: 80,
                child: const Text(
                  'Nenhum conteúdo disponível!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                height: 250,
                child: ListView.builder(
                  itemCount: listReproductions.length,
                  itemBuilder: (context, int index) => Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                      title: Expanded(
                        child: Text(
                          listReproductions[index].title,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      subtitle: Expanded(
                        child: Text(
                          listReproductions[index].nameNuvem,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                       updateUrl(index);
                        print(listReproductions[index].url);
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MovieDetailsController>();
    final state = controller.state;
    Widget? child;

    if (state is MovieDetailsLoadingState) {
          child = const Center(child: CircularProgressIndicator());
        } else if (state is MovieDetailsErrorState) {
          child = Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Ocorreu algum erro ${state.message}'),
          ));
        } else if (state is MovieDetailsSuccessState) {
          child = SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoPlayerWidget(
                    url: 
                    state.listReproductions.isEmpty
                        ? 'https://error/Teste.mp4'
                        : state.listReproductions[selectedItemCloud].url,
                    backdropPath: state.movieDetails.backdropPath!,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                Icons.star_half,
                                color: Colors.amber,
                              ),
                              Text(
                                state.movieDetails.voteAverage!.toStringAsFixed(1),
                                style: const TextStyle(
                                    color: Colors.amber, fontSize: 15),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '. ${state.movieDetails.releaseDate} ',
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                '. ${state.movieDetails.runtime} Minutos ',
                                style: const TextStyle(fontSize: 15),
                              ),
                                ],
                              ),
                            ),
                             IconButton(
                              onPressed: () =>_showCloudBottomSheet(
                                context,
                                state.listReproductions,
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                              icon: const Icon(Icons.cloud),
                            ),
                            IconButton(
                              onPressed: () {},
                              color: Colors.red,
                              icon: const Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                        Text(
                            'Gêneros: ${state.movieDetails.genres!.map((e) => e.name).join('/')}'),
                        const SizedBox(height: 10),
                        const Text('Sinopse:', style: TextStyle(fontSize: 26)),
                        const SizedBox(height: 10),
                        Text(
                          state.movieDetails.overview!,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
    return Scaffold(
            //extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
               centerTitle: true,
              title: Text(
                overflow: TextOverflow.ellipsis,
                softWrap: true,
               widget.movie.title!,
                style: const TextStyle(
                  fontSize: 26,
                ),
            ),),
            body: child ?? const SizedBox(),
          );    
  }
}
