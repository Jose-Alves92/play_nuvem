// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/models/media_model.dart';

import '../utils/app_routes.dart';
import '../utils/app_url_tmdb.dart';

class CategoryWidget extends StatelessWidget {
  final String titleGenre;
  final List<MediaModel> medias;

  const CategoryWidget({
    Key? key,
    required this.titleGenre,
    required this.medias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              itemCount: medias.length,
              itemBuilder: (context, int index) {
                return SizedBox(
                  width: size.width * .33,
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          
                            Navigator.of(context).pushNamed(
                                AppRoutes.MEDIA_DETAILS_PAGE,
                                arguments: medias[index]);
                    
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: AppUrlTmdb.image(medias[index].posterPath!),
                            placeholder: (context, url) => Container(color: Colors.grey , 
                            child: Center(child: Image.asset('assets/icons/icon_play_nuvem_branco.png', height: 50, width: 50, scale: 1.5),
                            ),
                            ),
                            fit: BoxFit.cover,
                            maxWidthDiskCache: 200,
                          ),
                        ),),
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