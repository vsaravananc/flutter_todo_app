class BuilderService {
  final Map<String, dynamic> _build = {};

  BuilderService markIsDone(bool isDone) {
    _build['isDone'] = isDone ? 1 : 0;
    return this;
  }

  Map<String, dynamic> get build => _build;
}
