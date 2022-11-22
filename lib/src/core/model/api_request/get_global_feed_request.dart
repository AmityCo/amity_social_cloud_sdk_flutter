// ignore_for_file: hash_and_equals

import 'package:amity_sdk/src/core/extension/extension.dart';
import 'package:amity_sdk/src/core/model/api_request/paginated_api_request.dart';

class GetGlobalFeedRequest extends PaginatedApiRequest {
  List<String>? dataTypes;
  GetGlobalFeedRequest({String? token, this.dataTypes, int limit = 10})
      : super(token, limit);

  Map<String, dynamic> toJson() => {
        'token': token,
        'limit': limit,
        'dataTypes[]': dataTypes == null
            ? null
            : List<String>.from(dataTypes!.map((x) => x)),
      }..removeNullValue();

  @override
  int get hashCode => 'GLOBAL_FEED_${dataTypes?.join('_')}'.hashCode;
}
