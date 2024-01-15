class EntityNotFoundException implements Exception {
  static final EntityNotFoundException _singleton = EntityNotFoundException._internal();

  factory EntityNotFoundException(){
    return _singleton;

  }
  final message = "Database query returns null invocation";

  @override
  String toString() {
    return message;
  }

  EntityNotFoundException._internal();
}