import 'package:flutter/material.dart';

import '../../core/utils/app_routes.dart';
import '../../core/utils/app_url_tmdb.dart';

import '../models/media_model.dart';

class CategoryComponent extends StatelessWidget {
  final String titleGenre;
  final List<Media> listMediasByGenres;
  final String mediaType;

  const CategoryComponent({
    Key? key,
    required this.titleGenre,
    required this.listMediasByGenres,
    required this.mediaType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleGenre,
                style: const TextStyle(fontSize: 26),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 270,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listMediasByGenres
                  .length, //moviesController.moviesGenreAction.length,
              itemBuilder: (context, int index) {
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 5),
                  child: InkWell(
                    onTap: () {
                      if (mediaType == 'movie') {
                        Navigator.of(context).pushNamed(
                            AppRoutes.MOVIE_DETAIL_PAGE,
                            arguments: listMediasByGenres[index]);
                      }
                      if (mediaType == 'tv') {
                        Navigator.of(context).pushNamed(AppRoutes.TV_DETAIL_PAGE,
                            arguments: listMediasByGenres[index]);
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: FadeInImage(
                            fadeInDuration: const Duration(milliseconds: 300),
                            fadeInCurve: Curves.ease,
                            fadeOutCurve: Curves.ease,
                            height: 200,
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.cover,
                            placeholder: const AssetImage(
                                'assets/images/placeholder.jpg'),
                            image: NetworkImage(
                              AppUrlTmdb.REQUEST_IMAGE(
                                listMediasByGenres[index].posterPath!,
                              ),
                              scale: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          listMediasByGenres[index].title ?? 'Erro!',
                          style: const TextStyle(fontSize: 15),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
