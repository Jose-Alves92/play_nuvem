import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/shared/models/media_details.dart';
import 'package:play_nuvem/src/shared/utils/app_routes.dart';
import 'package:play_nuvem/src/shared/utils/app_url_tmdb.dart';

class TrendingSlider extends StatelessWidget {
  final List<MediaDetails> medias;

  const TrendingSlider({super.key, required this.medias});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: medias.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.MEDIA_DETAILS_PAGE,
                  arguments: medias[index]);
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                        height: 300,
                        width: 200,
                        child: Image.network(
                          AppUrlTmdb.image(medias[index].posterPath!),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: medias[index].isAvailable
                          ? Colors.green.shade900
                          : Colors.grey,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
