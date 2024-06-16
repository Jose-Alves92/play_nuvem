// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:play_nuvem/src/models/home_content.dart';
import 'package:play_nuvem/src/models/media_details.dart';

abstract class IHomeService {
  

 

  Future<HomeContent> fetch();

  Future<List<MediaDetails>> getAllTrending();


  
}
