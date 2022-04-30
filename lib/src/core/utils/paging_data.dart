// import 'package:amity_sdk/src/core/model/api_request/paginated_api_request.dart';
// import 'package:amity_sdk/src/core/utils/tuple.dart';
// import 'package:amity_sdk/src/domain/model/amity_post.dart';

// class PagingData<T> {
//   final Tuple2<List<T>, String> _data;

//   PagingData(this._data);

//   PaginatedApiRequest? _request;

//   set request(PaginatedApiRequest? request) => _request = request;

//   Future<List<AmityPost>> fetchNextPage() {
//     _request.token = _data.item2;
//   }

//   List<T> get getData => _data.item1;
// }
