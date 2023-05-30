import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/vod/tv_details_controller.dart';
import 'package:provider/provider.dart';

import '../../shared/models/media_model.dart';
import '../../shared/models/reproduction_items.dart';
import 'tv_details_state.dart';
import 'widgets/video_player_widget.dart';

class TvDetailsPage extends StatefulWidget {
  final Media tv;
  const TvDetailsPage({
    super.key,
    required this.tv,
  });

  @override
  State<TvDetailsPage> createState() => _TvDetailsPageState();
}

class _TvDetailsPageState extends State<TvDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TvDetailsController>()
          .loadTvShows(tvId: widget.tv.id.toString());
    });
  }

  int selectedSeason = 1;
  int selectedItemCloud = 0;
  String episode = 'S01_E01';

  void updateUrl(int index) {
    setState(() {
      selectedItemCloud = index;
    });
  }

  _showCloudBottomSheet(
      BuildContext context, List<ReproductionItems> listReproductions) {
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
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
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
    final controller = context.watch<TvDetailsController>();
    final state = controller.state;
    Widget? child;
    print('tela');
    if (state is TvDetailsLoadingState) {
      child = const Center(child: CircularProgressIndicator());
    } else if (state is TvDetailsErrorState) {
      child = Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('Ocorreu algum erro: ${state.message}'),
      ));
    } else if (state is TvDetailsSuccessState) {
      child = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoPlayerWidget(
              url: state.listReproductions.isEmpty
                  ? 'https://error/Teste.mp4'
                  : state.listReproductions[selectedItemCloud].url,
              backdropPath: state.tvShowsDetails.backdropPath!,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          'Você esta assistindo: $episode',
                          // style: const TextStyle(
                          //   fontSize: 20,
                          // ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showCloudBottomSheet(
                            context, state.listReproductions),
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
                      value: selectedSeason,
                      underline: const SizedBox(),
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                      items: state.tvShowsDetails.seasons!.isNotEmpty
                          ? state.tvShowsDetails.seasons!
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.seasonNumber,
                                  child: Text('${e.name}'),
                                ),
                              )
                              .toList()
                          : null,
                      onChanged: (value) {
                        setState(() {
                          selectedSeason = value!;
                          print(selectedSeason);
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
                      itemCount: state.tvShowsDetails.seasons!.isNotEmpty
                          ? state
                              .tvShowsDetails
                              .seasons![
                                  selectedSeason - 1 < 0 ? 0 : selectedSeason]
                              .episodeCount!
                          : null,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            //imdbTv_S01_E01
                            var imdbIdTv = state.imdbId;
                            episode = 'S${selectedSeason >= 10 ? selectedSeason : '0$selectedSeason'}_E${index + 1 >= 10 ? index + 1 : '0${index + 1}'}';
                            var imdbIdAndEpisode = '${imdbIdTv}_$episode';
                            print(imdbIdAndEpisode);
                            controller.updateTvShows(
                              episode: imdbIdAndEpisode,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${index + 1}',
                            ),
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
                        state.tvShowsDetails.voteAverage!.toStringAsFixed(1),
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 15),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '. ${state.tvShowsDetails.firstAirDate} ',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                    'Gêneros: ${state.tvShowsDetails.genres!.map((e) => e.name).join('/')}',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const SizedBox(height: 10),
                  const Text('Sinopse:', style: TextStyle(fontSize: 26)),
                  const SizedBox(height: 10),
                  Text(
                    state.tvShowsDetails.overview!,
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          widget.tv.title!,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: child ?? const SizedBox(),
    );
  }
}
