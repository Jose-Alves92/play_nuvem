import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/video_player_component.dart';
import '../controllers/cloud_controller.dart';
import '../controllers/media_controller.dart';
import '../models/media_model.dart';
import '../models/tvshows_details_model.dart';

class DetailsTvPage extends StatefulWidget {
  final Media tv;
  const DetailsTvPage({
    super.key,
    required this.tv,
  });

  @override
  State<DetailsTvPage> createState() => _DetailsTvPageState();
}

class _DetailsTvPageState extends State<DetailsTvPage> {
  Future<void>? _future;
  TvShowsDetailsModel? details;
  // var valueSeason = ValueNotifier<int>(1);
  int valueSeason = 1;

  @override
  void initState() {
    super.initState();
    _future = getDetails();
  }

  Future<void> getDetails() async {
    details = await context
        .read<MediaController>()
        .fetchTvDetails(widget.tv.id.toString(), 'tv');
    await context.read<CloudController>().loadTvShows(widget.tv.id.toString());
  }

  bool isValid() => details!.seasons!.length == 1;

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
                        backgroundColor:Theme.of(context).colorScheme.secondary,
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
    // final cloudController =
    //     Provider.of<CloudController>(context, listen: false);
    // final mediaController =
    //     Provider.of<MediaController>(context, listen: false);

    // Future<void> getDetails() async {
    //   details =
    //       await mediaController.fetchTvDetails(widget.tv.id.toString(), 'tv');
    //   await cloudController.loadTvShows(widget.tv.id.toString());
    //   print(details!.toJson());
    // }
    final cloudController = context.watch<CloudController>();
     print('tela');
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ocorreu algum erro ${snapshot.error}'));
        } else {
          return Scaffold(
            appBar: AppBar(
              // elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                details!.name!,
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
             
            ),
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
                            const Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                'Seasons:',
                                style: TextStyle(
                                  fontSize: 26,
                                ),
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
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: DropdownButton(
                            value: valueSeason,
                            underline: const SizedBox(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                            items: details!.seasons!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.seasonNumber,
                                    child: Text('${e.name}'),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                valueSeason = value!;
                                print(valueSeason);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Episódios:'),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: isValid()
                                ? details!.seasons![0].episodeCount!
                                : details!.seasons![valueSeason].episodeCount!,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                // mouseCursor: MouseCursor.uncontrolled,
                                onTap: () {
                                  //imdbTv_S01_E01
                                  var imdbIdTv = cloudController.imdbId;
                                  var episode =
                                      '${imdbIdTv}_S${valueSeason >= 10 ? valueSeason : '0$valueSeason'}_E${index + 1 >= 10 ? index + 1 : '0${index + 1}'}';
                                  print(episode);
                                  cloudController.updateTvShows(episode);
                                },
                                child: Text(
                                  '${index + 1}',
                                ),
                              ),
                            ),
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
                              details!.voteAverage!.toStringAsFixed(1),
                              style: const TextStyle(
                                  color: Colors.amber, fontSize: 15),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '. ${details!.firstAirDate} ',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Text(
                          'Gêneros: ${details!.genres!.map((e) => e.name).join('/')}',
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        const SizedBox(height: 10),
                        const Text('Sinopse:', style: TextStyle(fontSize: 26)),
                        const SizedBox(height: 10),
                        Text(
                          details!.overview!,
                          style: const TextStyle(fontSize: 15),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        const SizedBox(height: 10),
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
