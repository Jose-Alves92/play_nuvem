import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/movie_details/movie_details_page.dart';
import 'package:play_nuvem/src/features/playlist/form_page/playlist_form_page.dart';
import 'package:play_nuvem/src/features/playlist/playlist_page.dart';
import 'package:play_nuvem/src/features/splash/splash_page.dart';
import 'package:play_nuvem/src/features/tv_details/tv_details_page.dart';
import 'package:play_nuvem/src/features/update_medias/update_medias.dart';
import 'package:play_nuvem/src/models/m3u/playlist.dart';
import 'package:play_nuvem/src/models/media_details.dart';


import '../shared/ui/theme/app_theme.dart';
import 'home/home_bottom_bar.dart';
import '../shared/utils/app_routes.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayNuvem',
      theme: AppTheme.appTheme,
      
      initialRoute: AppRoutes.SPLASH_SCREEN,
      routes: {
        AppRoutes.SPLASH_SCREEN: (context) => const SplashScreen(),
        AppRoutes.HOME_PAGE: (context) => const HomeBottomBar(),
        AppRoutes.MOVIE_DETAILS_PAGE: (context) {
          var movie = ModalRoute.of(context)!.settings.arguments as MediaDetails;
          return MovieDetailsPage(media: movie);
        } ,
        AppRoutes.TV_DETAILS_PAGE: (context) {
          var tv = ModalRoute.of(context)!.settings.arguments as MediaDetails;
          return TvDetailsPage(media: tv);
        } ,
        AppRoutes.PLAYLIST_PAGE: (context) => const PlaylistPage(),
        AppRoutes.PLAYLIST_FORM: (context) {
          var playlist = ModalRoute.of(context)!.settings.arguments as Playlist?;
          return PlaylistFormPage(playlist: playlist);
        },
        AppRoutes.UPDATE_MEDIAS:(context) => const UpdateMedias(),
      },
    );
  }
}
