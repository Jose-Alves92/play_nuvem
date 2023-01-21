import 'package:flutter/material.dart';
import 'package:play_nuvem/components/video_player_component.dart';
import 'package:play_nuvem/controllers/nuvem_controller.dart';
import 'package:play_nuvem/models/movie_detail_model.dart';
import 'package:provider/provider.dart';

class DetailsMoviePage extends StatefulWidget {
  final MovieDetailModel movie;
  const DetailsMoviePage({
    super.key,
    required this.movie,
  });

  @override
  State<DetailsMoviePage> createState() => _DetailsMoviePageState();
}

class _DetailsMoviePageState extends State<DetailsMoviePage> {
  Future<String> getUrl(BuildContext context) async {
    var url2 = await Provider.of<NuvemController>(context, listen: false).url;
    return url2;
  }

  Widget? futureBuilder(BuildContext context) {
    final futureController =
        Provider.of<NuvemController>(context, listen: false);
    return FutureBuilder(
        future: futureController
            .loadMovies(widget.movie.imdbId.toString())
            .then((_) => futureController.updateUrl()),
        builder: (context, snapshot) {
          return Container();
        });
  }

  @override
  void initState() {
    super.initState();
    //futureBuilder(context);
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    final _nuvemController = Provider.of<NuvemController>(context, listen: false);
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            //color: Colors.red,
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _nuvemController
                  .loadMovies(widget.movie.imdbId.toString())
                  .then((value) => _nuvemController.updateUrl()),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(
                      child: Text('Nenhum conteúdo disponível!'),
                    ),
                  );
                } 
                if (_nuvemController.url.isEmpty) {
                  return const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                else {
                  return const VideoPlayerComponent();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    widget.movie.title!,
                    style: const TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_half,
                        color: Colors.amber,
                      ),
                      Text(
                        widget.movie.voteAverage!.toStringAsFixed(1),
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '. ${widget.movie.releaseDate} ',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        '. ${widget.movie.runtime} Minutos ',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      //Text('Data de Lançamento: ${widget.movie.releaseDate}'),
                    ],
                  ),
                  Text(
                      'Gêneros: ${widget.movie.genres!.map((e) => e.name).join('/')}'),
                  const SizedBox(height: 10),
                  const Text('Sinopse:', style: TextStyle(fontSize: 26)),
                  const SizedBox(height: 10),
                  Text(
                    widget.movie.overview!,
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
}
