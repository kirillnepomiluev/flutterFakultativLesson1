import 'apiProviderTasks.dart';

class Repository {
  final moviesApiProvider = TasksApiProvider();

  Future<int> fetchAllMovies() {


    return
    moviesApiProvider.fetchMovieList();}

}