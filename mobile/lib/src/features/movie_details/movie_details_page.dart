// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:play_nuvem/src/models/media_details.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/ui/widgets/custom_button_cast.dart';
import 'package:play_nuvem/src/shared/ui/widgets/custom_button_favorite.dart';
import 'package:play_nuvem/src/shared/ui/widgets/video_player_widget.dart';

class MovieDetailsPage extends StatelessWidget {
  final MediaDetails? media;
  const MovieDetailsPage({
    Key? key,
    this.media,
  }) : super(key: key);


 


  @override
  Widget build(BuildContext context) {
    String url = media!.links!.isNotEmpty ? media!.links!.first : '';
    String textGenres = media!.genres!.map((e) => e.name).join('/');



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
                backdropPath: media!.backdropPath,
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      media!.name!,
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
                    media!.firstAirDate!.substring(0, 4),
                    style: AppTextStyle.bodySmall
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 17),
                      Text(
                        ' ${media!.voteAverage?.toStringAsFixed(0) ?? '0'}/10',
                        style: AppTextStyle.bodySmall
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  media!.runtime != null
                      ? Text(
                          '${media!.runtime}',
                          style: AppTextStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                media!.overview!,
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
              child: Text('Relacionados:', style: AppTextStyle.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
