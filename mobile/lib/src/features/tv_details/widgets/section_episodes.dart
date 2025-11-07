// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';

import 'package:play_nuvem/src/models/media_details.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/utils/app_url_tmdb.dart';

class SectionEpisodes extends StatelessWidget {
  final List<Episode> episodes;
  final ValueChanged<Episode>  updateSelectedEpisode;

  const SectionEpisodes({
    Key? key,
    required this.episodes, required this.updateSelectedEpisode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       
    return ListView.builder(
      // primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: episodes.length,
      itemBuilder: (context, index) {
       
        return MaterialButton(
          onPressed: () {
            updateSelectedEpisode(episodes[index]);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 100,
            color: AppColors.secondaryColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            AppUrlTmdb.image(episodes[index].stillPath!),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 30,
                      left: 55,
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Episodio: ${episodes[index].name}',
                          style: AppTextStyle.bodySmall,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Runtime: ${episodes[index].runtime ?? 30} m',
                          style: AppTextStyle.bodySmall,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
