import 'package:hive/hive.dart';

abstract class EkoObject extends HiveObject {
  DateTime? _createdAt = null;
  DateTime? _updatedAt = null;
  DateTime? _expiresAt= null;

  String? getId();

  DateTime? getCreatedAt() {
        return _createdAt;
    }

    void setCreatedAt( DateTime createdAt) {
        _createdAt = createdAt;
    }

    DateTime? getUpdatedAt() {
        return _updatedAt;
    }

    void setUpdatedAt(DateTime updatedAt) {
        _updatedAt = updatedAt;
    }

    DateTime? getExpiresAt() {
        return _expiresAt;
    }

    void setExpiresAt(DateTime expiresAt) {
        if (_expiresAt == null ) {
            _expiresAt = expiresAt;
        }else{
          if(expiresAt.isAfter(_expiresAt!)){
            _expiresAt = expiresAt;
          }
        }
    }
}
