import 'package:flutter/material.dart';
import 'package:play_nuvem/controllers/midia_controller.dart';
import 'package:play_nuvem/models/midia_model.dart';
import 'package:play_nuvem/models/movie_detail_model.dart';
import 'package:play_nuvem/models/tvshows_details_model.dart';
import 'package:play_nuvem/utils/api_tmdb_utils.dart';
import 'package:play_nuvem/utils/app_routes.dart';
import 'package:provider/provider.dart';

class CategoryComponent extends StatelessWidget {
  final String titleGenre;
  final List<Midia> listMidiasByGenres;
  final String midiaType;

  const CategoryComponent({
    Key? key,
    required this.titleGenre,
    required this.listMidiasByGenres, 
    required this.midiaType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _midiaController = Provider.of<MidiaController>(context,);

    Future<Object> _getDetails(String midiaId, String midiaType) async {
      if(midiaType == 'movie') {
      MovieDetailModel? details = await _midiaController.fetchMovieDetails(midiaId, midiaType);
      return details!;
      } else {
      TvShowsDetailsModel? details = await _midiaController.fetchTvDetails(midiaId, midiaType);
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
              itemCount: listMidiasByGenres
                  .length, //moviesController.moviesGenreAction.length,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {
                    _getDetails(listMidiasByGenres[index].id.toString(), midiaType).then((value) {
                      if(midiaType == 'movie') {
                      Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL_PAGE,
                        arguments: value);
                      }
                      if(midiaType == 'tv') {
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
                                ApiTmdbUtils.REQUEST_IMAGE(
                                    listMidiasByGenres[index].posterPath ?? 'colocar url image erro'),
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
                          listMidiasByGenres[index].title ?? 'Erro!',
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
