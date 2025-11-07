// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:play_nuvem/src/models/media_details.dart';

class HomeContent {
  final String date;
  final List<MediaDetails> trending;
  final List<MediaDetails> popularMovie;
  final List<MediaDetails> popularTv;
  HomeContent({
    required this.date,
    required this.trending,
    required this.popularMovie,
    required this.popularTv,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'trending': trending.map((x) => x.toMap()).toList(),
      'popularMovie': popularMovie.map((x) => x.toMap()).toList(),
      'popularTv': popularTv.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeContent.fromMap(Map<String, dynamic> map) {
    return HomeContent(
      date: map['date'],
      trending: List<MediaDetails>.from((map['trending']).map<MediaDetails>((x) => MediaDetails.fromMap(x as Map<String,dynamic>),),),
      popularMovie: List<MediaDetails>.from((map['popularMovie']).map<MediaDetails>((x) => MediaDetails.fromMap(x as Map<String,dynamic>),),),
      popularTv: List<MediaDetails>.from((map['popularTv']).map<MediaDetails>((x) => MediaDetails.fromMap(x as Map<String,dynamic>),),),
    );
  }



  HomeContent copyWith({
    String? date,
    List<MediaDetails>? trending,
    List<MediaDetails>? popularMovie,
    List<MediaDetails>? popularTv,
  }) {
    return HomeContent(
      date: date ?? this.date,
      trending: trending ?? this.trending,
      popularMovie: popularMovie ?? this.popularMovie,
      popularTv: popularTv ?? this.popularTv,
    );
  }
}
