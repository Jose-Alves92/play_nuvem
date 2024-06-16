// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:play_nuvem/src/features/home/services/i_home_service.dart';
import 'package:play_nuvem/src/repositories/media_info/i_media_info_repository.dart';
import 'package:play_nuvem/src/services/local_storage/i_local_storage_service.dart';
import 'package:play_nuvem/src/services/m3u_generate_content/I_m3u_generate-content_service.dart';
import 'package:play_nuvem/src/shared/data/category_data.dart';
import 'package:play_nuvem/src/models/category_model.dart';
import 'package:play_nuvem/src/models/home_content.dart';
import 'package:play_nuvem/src/models/media_details.dart';

class HomeServiceImp implements IHomeService {
  List<CategoryModel> categories = homeCategories;
  final IMediaInfoRepository _tmdbRepository;
  final ILocalStorageService _localStorage;
  final IM3uGenerateContentService _m3uGenerateContent;

  HomeServiceImp(
    this._m3uGenerateContent, this._tmdbRepository, this._localStorage
  );

  @override
  Future<HomeContent> fetch() async {
  

    String contentJson = await _localStorage.getString('homeContent');

    if (contentJson.isEmpty || DateTime.parse(jsonDecode(contentJson)['date']).day <= DateTime.now().day - 7) {
      List<MediaDetails> trending = await getAllTrending();

      var homeContent = HomeContent(date: DateTime.now().toIso8601String(), trending: trending, popularMovie: trending, popularTv: trending);
      
      
      Map<String, dynamic> contentToMap = homeContent.toMap();

      _localStorage.saveString('homeContent', jsonEncode(contentToMap));


      log('Search Api');
     
      return homeContent.copyWith(
        trending: await Future.wait(homeContent.trending.map((e) async { return  await _m3uGenerateContent.addLinks(e);}).toList()),
        popularMovie: await Future.wait(homeContent.popularMovie.map((e) async { return await _m3uGenerateContent.addLinks(e);}).toList()),
        popularTv: await Future.wait(homeContent.popularTv.map((e) async { return await _m3uGenerateContent.addLinks(e);}).toList()),
      );
    } 
    log('Search local');
    var newHomeContent = HomeContent.fromMap(jsonDecode(contentJson));
    log(newHomeContent.trending.length.toString());
    return newHomeContent.copyWith(
      trending: await Future.wait(newHomeContent.trending.map((e) async { return await _m3uGenerateContent.addLinks(e);}).toList()),
      popularMovie: await Future.wait(newHomeContent.popularMovie.map((e) async { return await _m3uGenerateContent.addLinks(e);}).toList()),
      popularTv: await Future.wait(newHomeContent.popularTv.map((e) async { return await _m3uGenerateContent.addLinks(e);}).toList()),
    );
    
  }

  @override
  Future<List<MediaDetails>> getAllTrending() async {
    var list = await _tmdbRepository.getAllTrending();
    
    var newList = await Future.wait(list.map((e) async {
      var mediaDetails = await _tmdbRepository.getDetails(e.id.toString(), e.mediaType!);
     
      if(mediaDetails.seasons != null) {
        var newMedia = await Future.wait(mediaDetails.seasons!.map((season) async {
        var episodes = await _tmdbRepository.getEpisodes(e.id.toString(), season.seasonNumber.toString());

          return season.copyWith(episodes: episodes);
        }).toList());

        return e.copyWith(genres: mediaDetails.genres, seasons: newMedia);
      } 
    
    return e.copyWith(genres: mediaDetails.genres);
    

    }).toList());
  
    return newList;
  }


  
}
