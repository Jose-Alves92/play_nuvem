// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:play_nuvem/src/shared/models/media_details.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_colors.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';
import 'package:play_nuvem/src/shared/utils/app_url_tmdb.dart';

class SectionEpisodes extends StatelessWidget {
  final List<Episode> episodes;
  final ValueChanged<String>  updateUrl;

  const SectionEpisodes({
    Key? key,
    required this.episodes, required this.updateUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       
    return ListView.builder(
      // primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: episodes.length,
      itemBuilder: (context, index) {
       
        return MaterialButton(
          onPressed: () {
            updateUrl(episodes[index].links.first);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 100,
            color: AppColors.secondaryColor,
            child: Row(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Episodio: ${episodes[index].name!}',
                        style: AppTextStyle.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Runtime: ${episodes[index].runtime}m',
                        style: AppTextStyle.bodySmall,
                      ),
                    ],
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
