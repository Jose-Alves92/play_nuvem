import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/video_player_component.dart';
import '../controllers/cloud_controller.dart';
import '../controllers/media_controller.dart';
import '../models/media_model.dart';
import '../models/movie_detail_model.dart';

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
  Future<void>? _future;
  MovieDetailModel? details;

   @override
  void initState() {
    super.initState();
    _future = getDetails();
  }

  Future<void> getDetails() async {
      details = await context.read<MediaController>().fetchMovieDetails(
          widget.movie.id.toString(), 'movie');
      await context.read<CloudController>().loadMovies(details!.imdbId.toString());
    }

  _showCloudBottomSheet() {
    final cloudController = context.read<CloudController>();
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return cloudController.listReproductionItems.isEmpty
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
                  itemCount: cloudController.listReproductionItems.length,
                  itemBuilder: (context, int index) => Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                      title: Expanded(
                        child: Text(
                          cloudController.listReproductionItems[index].title,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      subtitle: Expanded(
                        child: Text(
                          cloudController
                              .listReproductionItems[index].nameNuvem,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        cloudController.updateUrl(index: index);
                        print(cloudController.url);
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
    final cloudController = context.watch<CloudController>();

    return FutureBuilder(
      future: _future,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ocorreu algum erro ${snapshot.error}'));
        } else {
          return Scaffold(
            //extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
               centerTitle: true,
              title: Text(
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                details!.title!,
                style: const TextStyle(
                  fontSize: 26,
                ),
            ),),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoPlayerComponent(
                    url: cloudController.listReproductionItems.isEmpty
                        ? 'http://url.isEmpty.com'
                        : cloudController.listReproductionItems[0].url,
                    backdropPath: details!.backdropPath!,
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
                                details!.voteAverage!.toStringAsFixed(1),
                                style: const TextStyle(
                                    color: Colors.amber, fontSize: 15),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '. ${details!.releaseDate} ',
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                '. ${details!.runtime} Minutos ',
                                style: const TextStyle(fontSize: 15),
                              ),
                                ],
                              ),
                            ),
                            
                            
                             IconButton(
                              onPressed: _showCloudBottomSheet,
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
                            'Gêneros: ${details!.genres!.map((e) => e.name).join('/')}'),
                        const SizedBox(height: 10),
                        const Text('Sinopse:', style: TextStyle(fontSize: 26)),
                        const SizedBox(height: 10),
                        Text(
                          details!.overview!,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
