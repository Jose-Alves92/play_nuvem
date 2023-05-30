// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../shared/models/media_model.dart';
import '../../../shared/utils/app_routes.dart';
import '../../../shared/utils/app_url_tmdb.dart';


class CategoryWidget extends StatelessWidget {
  final String titleGenre;
  final List<Media> listMedias;
  final String? mediaType;
 

  const CategoryWidget({
    Key? key,
    required this.titleGenre,
    required this.listMedias,
    this.mediaType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  titleGenre,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                ),
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
            height: size.height * 0.25,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: listMedias.length,
              itemBuilder: (context, int index) {
                return SizedBox(
                  width: size.width * .33,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      if (listMedias[index].mediaType == 'movie' || mediaType == 'movie') {
                        Navigator.of(context).pushNamed(
                            AppRoutes.MOVIE_DETAIL_PAGE,
                            arguments: listMedias[index]);
                      }
                      if (listMedias[index].mediaType == 'tv' || mediaType == 'tv') {
                        Navigator.of(context).pushNamed(AppRoutes.TV_DETAIL_PAGE,
                            arguments: listMedias[index]);
                            listMedias[index];
                      }
                    },
                    child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(
                                AppUrlTmdb.REQUEST_IMAGE(listMedias[index].posterPath!),),
                              fit: BoxFit.cover,
                              scale: 1.5,
                            ),
                          ),
                          
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
