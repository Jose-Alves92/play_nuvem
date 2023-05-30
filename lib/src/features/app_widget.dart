import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/vod/movie_details_controller.dart';
import 'package:play_nuvem/src/features/vod/tv_details_controller.dart';
import 'package:play_nuvem/src/shared/services/connection_clouds/connections_clouds_imp.dart';
import 'package:play_nuvem/src/shared/services/local_storage/local_storage_imp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/models/media_model.dart';
import '../shared/repositories/media_repository_imp.dart';
import 'cloud/cloud_controller.dart';
import 'home/home_page.dart';
import '../shared/utils/app_routes.dart';
import 'vod/movie_details_page.dart';
import 'vod/movies_tabbar_controller.dart';
import 'vod/tv_details_page.dart';
import 'vod/recommendations_controller.dart';
import 'vod/tv_tabbar_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => MediaRepositoryImp()),
        Provider(create: (context) => ConnectionsCloudsImp()),
        Provider(create: (context) => LocalStorageImp()),
        ChangeNotifierProvider(
            create: ((context) => RecommendationsController(context.read<MediaRepositoryImp>()))),
        ChangeNotifierProvider(
            create: (context) => MoviesTabBarController(context.read<MediaRepositoryImp>())),
        ChangeNotifierProvider(
            create: (context) => TvTabBarController(context.read<MediaRepositoryImp>())),
        ChangeNotifierProvider(
            create: (context) => CloudController(context.read<LocalStorageImp>())),
        ChangeNotifierProvider(
          create: (context) => MovieDetailsController(
            context.read<MediaRepositoryImp>(),
            context.read<ConnectionsCloudsImp>(),
            context.read<LocalStorageImp>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TvDetailsController(
            context.read<MediaRepositoryImp>(),
            context.read<ConnectionsCloudsImp>(),
            context.read<LocalStorageImp>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PlayNuvem',
        theme: ThemeData.dark(),
        home: const HomePage(),
        routes: {
          AppRoutes.MOVIE_DETAIL_PAGE: (context) {
            final argMovie =
                ModalRoute.of(context)!.settings.arguments as Media;
            return DetailsMoviePage(movie: argMovie);
          },
          AppRoutes.TV_DETAIL_PAGE: (context) {
            final argTv = ModalRoute.of(context)!.settings.arguments as Media;
            return TvDetailsPage(
              tv: argTv,
            );
          }
        },
      ),
    );
  }
}
