// ignore_for_file: hash_and_equals

import 'package:amity_sdk/core/model/api_request/paginated_api_request.dart';

class GetGlobalFeedRequest extends PaginatedApiRequest {
  // final String? token;
  final List<String>? dataTypes;
  GetGlobalFeedRequest({String? token, this.dataTypes, int limit = 10})
      : super(token, limit);

  // set limit(int limit) => this.limit = limit;

  Map<String, dynamic> toJson() => {
        'token': token,
        'limit': limit,
        'dataTypes': dataTypes?.join(','),
      }..removeWhere((key, value) => value == null);

  @override
  int get hashCode => 'GLOBAL_FEED_${dataTypes?.join('_')}'.hashCode;
}
