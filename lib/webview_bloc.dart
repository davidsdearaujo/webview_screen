import 'package:rxdart/rxdart.dart';

class WebviewBloc {
  var _loadingController = BehaviorSubject<bool>.seeded(true);
  Observable<bool> get loadingStream => _loadingController.stream;
  Sink<bool> get loadingSink => _loadingController.sink;

  void dispose() {
    _loadingController.close();
  }
}
