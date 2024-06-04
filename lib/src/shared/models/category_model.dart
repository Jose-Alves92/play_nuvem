

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:play_nuvem/src/shared/models/media_model.dart';

class CategoryModel {
  int? id;
  String name;
  List<MediaModel>? medias; 
  CategoryModel({
    this.id,
    required this.name,
    this.medias,
  });
 
  

  
}
