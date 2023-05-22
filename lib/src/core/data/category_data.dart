

import '../../app/models/genres_model.dart';

class CategoryData {
  final List<String> moviesGenresId = [
    '28', '12', '16', '35', '80', '99', '18', '10751', '14', '36', '27', '10402', '9648', '10749', '878', '10770', '53', '10752', '37',
  ];
 
  Future<List<Genros>> fetchMoviesGenres() async {
    return moviesGenres;
  }
  final List<Genros> moviesGenres = [
    Genros(id: 28, name: 'Ação'),
    Genros(id: 12, name: 'Aventura'),
    Genros(id: 16, name: 'Animação'),
    Genros(id: 35, name: 'Comédia'),
    Genros(id: 80, name: 'Crime'),
    Genros(id: 99, name: 'Documentário'),
    Genros(id: 18, name: 'Drama'),
    Genros(id: 10751, name: 'Família'),
    Genros(id: 14, name: 'Fantasia'),
    Genros(id: 36, name: 'História'),
    Genros(id: 27, name: 'Terror'),
    Genros(id: 10402, name: 'Música'),
    Genros(id: 9648, name: 'Mistério'),
    Genros(id: 10749, name: 'Romance'),
    Genros(id: 878, name: 'Ficção científica'),
    Genros(id: 10770, name: 'Cinema TV'),
    Genros(id: 53, name: 'Thriller'),
    Genros(id: 10752, name: 'Guerra'),
    Genros(id: 37, name: 'Faroeste'),
  ];
}

//    Future<List<MidiaModel>> fetchMoviesByGenres() async {
//     return moviesByGenres;
//   }
//   final List<MidiaModel> moviesByGenres = [
//     MidiaModel(
//       originalTitle: 'Black Adam',
//       title: 'Adão Negro',
//       id: 436270,
//       genreIds: [28],
//     ),
//     MoviesModel(
//       originalTitle: 'Black Adam',
//       title: 'Adão Negro',
//       id: 436270,
//       genreIds: [28],
//     ),
//     MoviesModel(
//       originalTitle: 'Black Adam',
//       title: 'Adão Negro',
//       id: 436270,
//       genreIds: [28],
//     ),
//     MoviesModel(
//       originalTitle: 'Black Adam',
//       title: 'Adão Negro',
//       id: 436270,
//       genreIds: [28],
//     ),
//     MoviesModel(
//       originalTitle: 'Black Adam',
//       title: 'Adão Negro',
//       id: 436270,
//       genreIds: [28],
//     ),
//     MoviesModel(
//       originalTitle: 'Black Adam',
//       title: 'Adão Negro',
//       id: 436270,
//       genreIds: [28],
//     ),
//   ];

// }

  

// Map list2 = { 28: {
//     1: {'adult': false, 'backdrop_path': '/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg', 'genre_ids': [28, 14, 878], 'id': 436270, 'original_language': 'en', 'original_title': 'Black Adam', 'overview': 'Quase 5.000 anos depois de ter sido concedido com os poderes onipotentes dos deuses egípcios - e de ter sido preso, - Adão Negro se ergue de seu túmulo, pronto para trazer sua justiça ao mundo moderno.', 'popularity': 6345.586, 'poster_path': '/9z256FFPDsL7kSVJ9oyLELaN1ph.jpg', 'release_date': '2022-10-19', 'title': 'Adão Negro', 'video': false, 'vote_average': 7.3, 'vote_count': 2683}
//   }};


//  Map<int, dynamic> listTest = { 
//     28: {
//       1: [
//             {"adult": false, "backdrop_path": "/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg", "genre_ids": [28, 14, 878], "id": 436270, "original_language": "en", "original_title": "Black Adam", "overview": "Quase 5.000 anos depois de ter sido concedido com os poderes onipotentes dos deuses egípcios - e de ter sido preso, - Adão Negro se ergue de seu túmulo, pronto para trazer sua justiça ao mundo moderno.", "popularity": 6345.586, "poster_path": "/9z256FFPDsL7kSVJ9oyLELaN1ph.jpg", "release_date": "2022-10-19", "title": "Adão Negro", "video": false, "vote_average": 7.3, "vote_count": 2683},
//         ],
//     },
     
