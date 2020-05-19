import 'package:rxdart/rxdart.dart';


class TasksBloc {
  final _moviesFetcher = PublishSubject<int>();

  Stream<int> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    _isDisposed = false;
    _moviesFetcher.addStream(getRandomValues());
  }
  Stream<int> getRandomValues() async* {
      int value = 0;
    while (!_isDisposed) {
      await Future.delayed(Duration(seconds: 1));
      value++;
      yield value;
    }
  }

  bool _isDisposed = false;
  void dispose() {
    _isDisposed = true;
    _moviesFetcher.close();
  }

}
final bloc = TasksBloc();