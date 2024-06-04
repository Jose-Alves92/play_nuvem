// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';

import 'package:m3u_parser_nullsafe/m3u_parser_nullsafe.dart';

import 'package:play_nuvem/src/services/http_client/dio_service_imp.dart';
import 'package:play_nuvem/src/services/local_storage/i_local_storage_service.dart';
import 'package:play_nuvem/src/services/m3u_generate_content/I_m3u_generate-content_service.dart';
import 'package:play_nuvem/src/shared/models/m3u/group_media.dart';
import 'package:play_nuvem/src/shared/models/m3u/playlist.dart';
import 'package:play_nuvem/src/shared/models/media_details.dart';

class M3uGenerateContentServiceImp implements IM3uGenerateContentService {
  final ILocalStorageService _localStorageService;
  M3uGenerateContentServiceImp(
    this._localStorageService,
  );

  List<GroupMedia> channelGroupList = [];

  @override
  Future<List<GroupMedia>> fetch() async {
    String contentJson = await _localStorageService.getString('Content');
    

    if (contentJson.isEmpty) {
      var newChannelGroupList = await convertPlaylistData();

      var contentToMap = newChannelGroupList.map((e) => e.toMap()).toList();
     
    _localStorageService.saveString('Content', jsonEncode(contentToMap));
     

      log('Search content link');
      return newChannelGroupList;
    } else {
      
      List<dynamic> contentFromMap = jsonDecode(contentJson);
      channelGroupList = contentFromMap.map((e) => GroupMedia.fromMap(e as Map<String, dynamic>)).toList();

      log('Search content local');
      return channelGroupList;
    }
  }
  @override
  updateContent() async {
      await _localStorageService.remove('Content');

      var newChannelGroupList = await convertPlaylistData();

      var contentToMap = newChannelGroupList.map((e) => e.toMap()).toList();
     
      await _localStorageService.saveString('Content', jsonEncode(contentToMap));
     

      return newChannelGroupList;
  }
  @override
  Future<MediaDetails> addLinks(MediaDetails mediaDetails) async{
    var channelGroup = channelGroupList.isEmpty ? await fetch(): channelGroupList;

    if(mediaDetails.mediaType == 'tv' && mediaDetails.seasons != null){
      var list = channelGroup.firstWhere((groupMedia) => groupMedia.groupTitle == 'Series');
     
      if(list.tvShows.any((tvElement) => tvElement.title == mediaDetails.name)) {
        var tv = list.tvShows.firstWhere((tvElement) => tvElement.title == mediaDetails.name);
        
        var newSeason = mediaDetails.seasons!.map<Seasons>((season){
          if(tv.seasons.any((seasonElement) => seasonElement.title == 'S${season.seasonNumber}')){
            var seasonContent = tv.seasons.firstWhere((seasonElement) => seasonElement.title == 'S${season.seasonNumber}');

            var newEpisode = season.episodes!.map<Episode>((episode) {
              
              if(seasonContent.episodes.any((episodeElement) => episodeElement.title == 'E${episode.episodeNumber}')){
                var episodeContent = seasonContent.episodes.firstWhere((episodeElement) => episodeElement.title == 'E${episode.episodeNumber}');
                return episode.copyWith(links: episodeContent.links);
                
              }
              return episode;
            }).toList(); 
            
          return season.copyWith(episodes: newEpisode);
          }
        return season;
        } ).toList();
        return mediaDetails.copyWith(seasons: newSeason, isAvailable: true);
      }
      return mediaDetails;
    } else {
        
        var list = channelGroup.firstWhere((groupMedia) => groupMedia.groupTitle == 'Filmes', orElse: () => channelGroupList.first);
        /*log(list.toMap().toString());
        log('listm3u ${list.movies.any((element) => element.title == mediaDetails.name)}');
        list.movies.any((element) { 
          log('${element.title} | ${mediaDetails.name}');
          return element.title == mediaDetails.name;
        });*/
        if(list.movies.any((element) => element.title == mediaDetails.name)){
          var movieContent = list.movies.firstWhere((element) => element.title == mediaDetails.name);
          return mediaDetails.copyWith(links: movieContent.links, isAvailable: true);
        } else {
          return mediaDetails;
        }
    }
  }


  @override
  Future<List<GroupMedia>> convertPlaylistData() async {
    final playlistJson = await _localStorageService.getString('playlist');
    final List<Map<String, dynamic>> playlistDecode = jsonDecode(playlistJson);
    final playlist = playlistDecode.map((e) => Playlist.fromMap(e)).toList();

    await Future.forEach(playlist, (playlist) async* {

    final result = await DioServiceImp().get(playlist.url);
    final m3uGenerateList = M3uList.load(result.data);

    await Future.forEach(m3uGenerateList.items, (item) {
      final groupTitle = item.groupTitle.split(' ').first;

      if (groupTitle == 'Filmes') {
        converterMovie(item);
      } else if (groupTitle == 'Series') {
        converterTv(item);
      }
    },);
    });
    return channelGroupList;
  }

  @override
  void converterMovie(M3uItem item) {
    final title = item.title.split(RegExp(r'[(][0-9][0-9][0-9][0-9]')).first.trim();
    final link = item.link;

    if (channelGroupList.any((element) => element.groupTitle == 'Filmes',)) {
      var channelGroup = channelGroupList.firstWhere((element) => element.groupTitle == 'Filmes');

      if (channelGroup.movies.any((element) => element.title == title)) {
        var movie = channelGroup.movies.firstWhere((element) => element.title == title);
        movie.links.add(link);

      } else {
      
        channelGroup.movies.add(MoviesContent(title: title, links: [link]));
      }
    } else {
      channelGroupList.add(
        GroupMedia(groupTitle: 'Filmes', movies: [
          MoviesContent(title: title, links: [link])
        ]),
      );
    }
  }

  @override
  void converterTv(M3uItem item) {
    final titleCompleat = item.title;
    final titleSerie = titleCompleat.split(RegExp(r'S[0-9][0-9]')).first.trim(); //serie sem S00 E00
    final serieWithSeason = titleCompleat.split(RegExp(r'E[0-9][0-9]')).first; // title S00
    final seasonTitle = serieWithSeason.substring(serieWithSeason.length - 4, serieWithSeason.length - 1).trim(); // S00
    final episodeTitle = titleCompleat.split(RegExp(r'S[0-9][0-9]')).last.trim(); //E00
    final link = item.link;

    if (channelGroupList.any((element) => element.groupTitle == 'Series')) {
      var channelGroup = channelGroupList.firstWhere((element) => element.groupTitle == 'Series');

      if (channelGroup.tvShows.any((element) => element.title == titleSerie)) {
        var serie = channelGroup.tvShows.firstWhere((element) => element.title == titleSerie);

        if (serie.seasons.any((element) => element.title == seasonTitle)) {
          var season = serie.seasons.firstWhere((element) => element.title == seasonTitle);

          if (season.episodes.any((element) => element.title == episodeTitle)) {
            var episode = season.episodes.firstWhere((element) => element.title == episodeTitle);
            episode.links.add(link);

          } else {
            season.episodes.add(EpisodesContent(title: episodeTitle, links: [link]));
          }
        } else {
          serie.seasons.add(
            SeasonContent(
              title: seasonTitle,
              episodes: [
                EpisodesContent(title: episodeTitle, links: [link])
              ],
            ),
          );
        }
      } else {
        channelGroup.tvShows.add(
          TvShowsContent(
            title: titleSerie,
            seasons: [
              SeasonContent(
                title: seasonTitle,
                episodes: [
                  EpisodesContent(title: episodeTitle, links: [link])
                ],
              ),
            ],
          ),
        );
      }
    } else {
      channelGroupList.add(
        GroupMedia(
          groupTitle: 'Series',
          tvShows: [
            TvShowsContent(
              title: titleSerie,
              seasons: [
                SeasonContent(
                  title: seasonTitle,
                  episodes: [
                    EpisodesContent(title: episodeTitle, links: [link]),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
