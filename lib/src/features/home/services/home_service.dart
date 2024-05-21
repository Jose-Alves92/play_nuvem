// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:play_nuvem/src/repositories/tmdb/tmdb_repository.dart';
import 'package:play_nuvem/src/shared/data/category_data.dart';
import 'package:play_nuvem/src/shared/models/category_model.dart';

class HomeService {
  List<CategoryModel> categories = homeCategories;
  final TmdbRepository tmdbRepository;

  HomeService({
    required this.tmdbRepository,
  });

  Future<List<CategoryModel>> fetch() async {
   
    for (var category in categories) {
      if (category.name == 'Em Tendência') {
        var result = await tmdbRepository.getAllTrending();
        category.medias = result;
      } else if (category.name == 'Filmes Popular') {
        var result = await tmdbRepository.getMoviePopular();
        category.medias = result;
      } else if (category.name == 'Series Popular') {
        var result = await tmdbRepository.getTvPopular();
        category.medias = result;
      }
    }
  
    return categories;
  }
}
