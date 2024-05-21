// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:play_nuvem/src/shared/models/category_model.dart';

enum HomeStatus {
  initial,
  loading,
  error,
  success,
}

class HomeState {
  HomeStatus status;
  List<CategoryModel> categories;
  HomeState({
    required this.status,
    required this.categories,
  });

  factory HomeState.initial() {
    return HomeState(status: HomeStatus.initial, categories: []);
  }

  HomeState copyWith({
    HomeStatus? status,
    List<CategoryModel>? categories,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }
}
