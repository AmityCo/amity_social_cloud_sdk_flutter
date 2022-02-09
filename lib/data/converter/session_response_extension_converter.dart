import 'package:amity_sdk/data/response/session_response.dart';
import 'package:amity_sdk/domain/domain.dart';

extension SessionResponseExtension on SessionResponse {
  AmityUser convertToAmityUser() {
    return AmityUser();
  }
}
