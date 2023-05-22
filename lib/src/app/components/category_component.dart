import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../core/utils/app_routes.dart';
import '../../core/utils/app_url_tmdb.dart';
import '../controllers/media_controller.dart';
import '../models/media_model.dart';
import '../models/movie_detail_model.dart';
import '../models/tvshows_details_model.dart';


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
    final _mediaController = Provider.of<MediaController>(context,);

    Future<Object> _getDetails(String mediaId, String mediaType) async {
      if(mediaType == 'movie') {
      MovieDetailModel? details = await _mediaController.fetchMovieDetails(mediaId, mediaType);
      return details!;
      } else {
      TvShowsDetailsModel? details = await _mediaController.fetchTvDetails(mediaId, mediaType);
      return details!;
      }
    }
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
                return InkWell(
                  onTap: () {
                    _getDetails(listMediasByGenres[index].id.toString(), mediaType).then((value) {
                      if(mediaType == 'movie') {
                      Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL_PAGE,
                        arguments: value);
                      }
                      if(mediaType == 'tv') {
                        Navigator.of(context).pushNamed(AppRoutes.TV_DETAIL_PAGE,
                        arguments: value);
                      }
                    });
                    
                  },
                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(
                                AppUrlTmdb.REQUEST_IMAGE(
                                    listMediasByGenres[index].posterPath ?? 'colocar url image erro'),
                              ),
                              fit: BoxFit.cover,
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
