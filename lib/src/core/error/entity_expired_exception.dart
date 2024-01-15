class EntityExpiredException implements Exception{
  static final EntityExpiredException _singleton = EntityExpiredException._internal();

  factory EntityExpiredException(){
    return _singleton;

  }
  final message = "Entity already exceeded expiration";

  @override
  String toString() {
    return message;
  }

  EntityExpiredException._internal();
}