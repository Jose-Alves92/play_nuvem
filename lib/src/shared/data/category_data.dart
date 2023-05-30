


import '../models/genres_model.dart';

class CategoryData {
  final List<String> moviesGenresId = [
    '28', '12', '16', '35', '80', '99', '18', '10751', '14', '36', '27', '10402', '9648', '10749', '878', '10770', '53', '10752', '37',
  ];
 
  Future<List<Genres>> fetchMoviesGenres() async {
    return moviesGenres;
  }
  final List<Genres> moviesGenres = [
    Genres(id: 28, name: 'Ação'),
    Genres(id: 12, name: 'Aventura'),
    Genres(id: 16, name: 'Animação'),
    Genres(id: 35, name: 'Comédia'),
    Genres(id: 80, name: 'Crime'),
    Genres(id: 99, name: 'Documentário'),
    Genres(id: 18, name: 'Drama'),
    Genres(id: 10751, name: 'Família'),
    Genres(id: 14, name: 'Fantasia'),
    Genres(id: 36, name: 'História'),
    Genres(id: 27, name: 'Terror'),
    Genres(id: 10402, name: 'Música'),
    Genres(id: 9648, name: 'Mistério'),
    Genres(id: 10749, name: 'Romance'),
    Genres(id: 878, name: 'Ficção científica'),
    Genres(id: 10770, name: 'Cinema TV'),
    Genres(id: 53, name: 'Thriller'),
    Genres(id: 10752, name: 'Guerra'),
    Genres(id: 37, name: 'Faroeste'),
  ];
}

