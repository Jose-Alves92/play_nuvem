// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:play_nuvem/src/shared/models/home_content.dart';

enum HomeStatus {
  initial,
  loading,
  error,
  success,
}

class HomeState {
  HomeStatus status;
  HomeContent? homeContent;
  HomeState({
    required this.status,
    this.homeContent,
  });

  factory HomeState.initial() {
    return HomeState(status: HomeStatus.initial);
  }

  HomeState copyWith({
    HomeStatus? status,
    HomeContent? homeContent,
  }) {
    return HomeState(
      status: status ?? this.status,
      homeContent: homeContent ?? this.homeContent,
    );
  }
}
