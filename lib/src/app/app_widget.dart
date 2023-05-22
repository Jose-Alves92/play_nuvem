import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/media_controller.dart';
import 'controllers/nuvem_controller.dart';
import 'models/movie_detail_model.dart';
import 'models/tvshows_details_model.dart';
import 'pages/details_movie_page.dart';
import 'pages/details_tv_page.dart';
import 'pages/home_page.dart';
import '../core/utils/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => MediaController()),
        ),
        ChangeNotifierProvider(create: ((context) => NuvemController()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PlayNuvem',
        theme: ThemeData.dark(),
        home: const HomePage(),
        routes: {
          AppRoutes.MOVIE_DETAIL_PAGE:(context) {
            final argMovie = ModalRoute.of(context)!.settings.arguments as MovieDetailModel;
            return DetailsMoviePage(movie: argMovie,);
            },
          AppRoutes.TV_DETAIL_PAGE:(context) {
            final argTv = ModalRoute.of(context)!.settings.arguments as TvShowsDetailsModel;
            return DetailsTvPage(tv: argTv,);
            }
        },
      ),
    );
  }
}