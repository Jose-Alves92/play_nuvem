import 'package:flutter/material.dart';
import 'package:play_nuvem/controllers/midia_controller.dart';
import 'package:play_nuvem/controllers/nuvem_controller.dart';
import 'package:play_nuvem/models/midia_model.dart';
import 'package:play_nuvem/models/movie_detail_model.dart';
import 'package:play_nuvem/models/tvshows_details_model.dart';
import 'package:play_nuvem/pages/details_movie_page.dart';
import 'package:play_nuvem/pages/details_tv_page.dart';
import 'package:play_nuvem/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => MidiaController()),
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
