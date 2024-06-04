// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/models/media_details.dart';
import 'package:play_nuvem/src/shared/ui/styles/app_text_style.dart';

import '../utils/app_routes.dart';
import '../utils/app_url_tmdb.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final List<MediaDetails> medias;

  const CategoryWidget({
    Key? key,
    required this.title,
    required this.medias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.titleMedium,
                  ),
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
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: medias.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          
                            Navigator.of(context).pushNamed(
                                AppRoutes.MEDIA_DETAILS_PAGE,
                                arguments: medias[index]);
                    
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 200,
                            width: 150,
                            child: CachedNetworkImage(
                              imageUrl: AppUrlTmdb.image(medias[index].posterPath!),
                              placeholder: (context, url) => Container(color: Colors.grey , 
                              child: Center(child: Image.asset('assets/icons/icon_play_nuvem_branco.png', height: 50, width: 50, scale: 1.5),
                              ),
                              ),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              maxWidthDiskCache: 200,
                            ),
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
