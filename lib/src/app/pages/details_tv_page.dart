import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/video_player_component.dart';
import '../controllers/nuvem_controller.dart';
import '../models/tvshows_details_model.dart';

class DetailsTvPage extends StatefulWidget {
  final TvShowsDetailsModel tv;
  const DetailsTvPage({
    super.key,
    required this.tv,
  });

  @override
  State<DetailsTvPage> createState() => _DetailsTvPageState();
}

class _DetailsTvPageState extends State<DetailsTvPage> {
  Widget? futureBuilder(BuildContext context) {
    final futureController =
        Provider.of<NuvemController>(context, listen: false);
    return FutureBuilder(
        future: futureController
            .loadTvShows(widget.tv.id.toString())
            .then((_) => futureController.updateUrl()),
        builder: (context, snapshot) {
          return Container();
        });
  }

  @override
  void initState() {
    super.initState();
    futureBuilder(context);
  }

  @override
  Widget build(BuildContext context) {
    //final _mediaQuery = MediaQuery.of(context).size;
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
                  .loadTvShows(widget.tv.id.toString())
                  .then((value) { 
                    if(_nuvemController.listReproductionItems.isNotEmpty) {
                    _nuvemController.updateUrl();
                    } else {
                      return;
                    }
                    },),
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
                    widget.tv.name!,
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
                        widget.tv.voteAverage!.toStringAsFixed(1),
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '. ${widget.tv.firstAirDate} ',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                      'Gêneros: ${widget.tv.genres!.map((e) => e.name).join('/')}'),
                  const SizedBox(height: 10),
                  const Text('Sinopse:', style: TextStyle(fontSize: 26)),
                  const SizedBox(height: 10),
                  Text(
                    widget.tv.overview!,
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
