import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/enum/amity_stream_status.dart';
import 'package:amity_sdk/src/core/model/api_request/stream_query_request.dart';
import 'package:amity_sdk/src/core/utils/stream_live_collection.dart';
import 'package:amity_sdk/src/domain/model/amity_stream/amity_stream.dart';
import 'package:amity_sdk/src/domain/usecase/stream/stream_qurey_usecase.dart';

class StreamGetQueryBuilder {
  late StreamQueryUseCase _useCase;
  late StreamQueryRequest _request;

  bool _stackFromEnd = false;
  bool _isLive = false;
  bool? _isDeleted = false;
  List<String> _statuses = [];
  String _sortBy = "lastCreated";

  StreamGetQueryBuilder(StreamQueryUseCase useCase) {
    _useCase = useCase;
    _request = StreamQueryRequest();
  }

  StreamGetQueryBuilder isLive(bool isLive) {
    _isLive = isLive;
    return this;
  }

  StreamGetQueryBuilder stackFromEnd(bool stackFromEnd) {
    _stackFromEnd = stackFromEnd;
    return this;
  }

  StreamGetQueryBuilder sortBy(String sortBy) {
    _sortBy = sortBy;
    return this;
  }

  StreamGetQueryBuilder status(List<AmityStreamStatus> statuses) {
    statuses.forEach((element) {
      _statuses.add(element.name);
    });
    return this;
  }

  StreamGetQueryBuilder isDeleted(bool isDeleted) {
    _isDeleted = isDeleted;
    return this;
  }

  StreamLiveCollection getLiveCollection({int? pageSize = 20}) {
    return StreamLiveCollection(request: (() => build(pageSize: pageSize)));
  }


  /// getPagingData
  Future<PageListData<List<AmityStream>, String>> getPagingData(
      {String? token, int? limit = 20}) async {
    final data =
        await _useCase.get(build(pageSize: limit)..options!.token = token);

    return data;
  }

  StreamQueryRequest build({int? pageSize = 20}) {
    _request.isLive = _isLive;
    _request.isDeleted = _isDeleted;
    _request.statuses = _statuses;
    _request.stackFromEnd = _stackFromEnd;
    _request.sortBy = _sortBy;
    _request.options = OptionsRequest();

    // if (!_stackFromEnd) {
    //   _request.options!.first = pageSize;
    // } else {
    //   _request.options!.last = pageSize;
    // }
    _request.options!.limit = pageSize;
    // _request.options!.after = pageSize;
    // _request.options!.before = pageSize;
    // _request.options!.after = pageSize;

    return _request;
  }


  /// Query
  Future<List<AmityStream>> query({String? token, int? limit = 20}) async {
    final data =
        await _useCase.get(build(pageSize: limit)..options!.token = token);

    return data.data;
  }

}
