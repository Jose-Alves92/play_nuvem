import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/tv_details/widgets/section_episodes.dart';
import 'package:play_nuvem/src/models/media_details.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/ui/widgets/custom_button_cast.dart';
import 'package:play_nuvem/src/shared/ui/widgets/custom_button_favorite.dart';
import 'package:play_nuvem/src/shared/ui/widgets/video_player_widget.dart';

class TvDetailsPage extends StatefulWidget {
  final MediaDetails media;
  const TvDetailsPage({super.key, required this.media});

  @override
  State<TvDetailsPage> createState() => _TvDetailsPageState();
}

class _TvDetailsPageState extends State<TvDetailsPage> {

  var url = '';
  late int selectedSeason;
  late int selectedEpisode;

  void getUrl() {
      url = widget.media.seasons![selectedSeason].episodes![selectedEpisode].links!.isEmpty 
      ? '' 
      : widget.media.seasons![selectedSeason].episodes![selectedEpisode].links!.first;
  }

   void updateSelectedEpisode(Episode episode){
    setState(() {
      selectedEpisode = episode.episodeNumber ?? 0;
      getUrl();
    });
  }

  void updateUrl(String newUrl){
    setState(() {
      url = newUrl;
    });
  }


  @override
  void initState() {
    super.initState();
    selectedSeason = widget.media.seasons?[0].seasonNumber ?? 0;
    selectedEpisode = widget.media.seasons?[0].episodes?[0].episodeNumber ?? 0;
    getUrl();
  }


  @override
  Widget build(BuildContext context) {
    String textGenres = widget.media.genres!.map((e) => e.name).join('/');


    return Scaffold(
      appBar: AppBar(
        actions: const [CustomButtonCast(), CustomButtonFavorite()],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            VideoPlayerWidget(
                url: url, 
                backdropPath: widget.media.backdropPath,
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('${widget.media.name!} : S$selectedSeason:E$selectedEpisode',
                      style: AppTextStyle.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: IconButton(
                      icon: const Icon(Icons.movie_outlined),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Row(
                children: [
                  Text(
                    widget.media.firstAirDate!.substring(0, 4),
                    style: AppTextStyle.bodySmall
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 17),
                      Text(
                        ' ${widget.media.voteAverage?.toStringAsFixed(0) ?? '0'}/10',
                        style: AppTextStyle.bodySmall
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  widget.media.runtime != null
                      ? Text(
                          '${widget.media.runtime ?? ''}',
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(width: 10),
                  widget.media.numberOfSeasons != null
                      ? Text(
                          '${widget.media.numberOfSeasons} Seasons',
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                widget.media.overview ?? '',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.left,
                style: AppTextStyle.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                'Genres: $textGenres',
                // maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppTextStyle.bodySmall
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ),
           const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text('Episódios: '),
            ),
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.secondaryColor,
                ),
                padding: const EdgeInsets.all(8),
                child: DropdownButton(
                  dropdownColor: AppColors.secondaryColor,
                    isExpanded: true,
                    value: selectedSeason,
                    underline: const SizedBox(),
                    style: AppTextStyle.bodyMedium,
                    items: widget.media.seasons!.map(
                          (e) => DropdownMenuItem(
                            value: e.seasonNumber,
                            child: Text('${e.name}',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1),
                          
                          ),
                        )
                        .toList(),// : const [DropdownMenuItem(child: SizedBox())],
                    onChanged: (value) {
                      setState(() {
                        selectedSeason = value!;
                        //get first episode
                        selectedEpisode = widget.media.seasons?[selectedEpisode].episodes?.first.episodeNumber ?? 0;
                        getUrl();
                        log(selectedSeason.toString());
                      });
                    },
                  ),
              ),
            ),
            Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SectionEpisodes(
                    episodes: widget.media.seasons!.firstWhere((element) => element.seasonNumber == selectedSeason).episodes!, 
                    updateSelectedEpisode: updateSelectedEpisode,
                  ),
                ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text('Relacionados:', style: AppTextStyle.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
