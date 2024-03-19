import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/model/api_request/get_reach_user_request.dart';
import 'package:amity_sdk/src/domain/usecase/user/get_reach_user_usecase.dart';

class AmityQueryReachUserBuilder {
  late GetReachUserUseCase _useCase;
  late AmityViewedType _viewedType;
  late String  _viewedId;

  final GetReachUserRequest _request = GetReachUserRequest();
  AmityQueryReachUserBuilder({required GetReachUserUseCase useCase, required AmityViewedType viewedType , required String  viewedId}) {
    _useCase = useCase;
    _viewedType = viewedType;
    _viewedId = viewedId;
  }


Future<List<AmityUser>> query() async {
    if(_viewedType == AmityViewedType.POST){
      _request.postId = _viewedId;
      }else{
      _request.storyId = _viewedId;
      }
    final amityUsers = await _useCase.get(_request);

    return amityUsers.data;
  }

  /// Query User
  Future<PageListData<List<AmityUser>, String>> getPagingData(
      {String? token, int? limit}) async {
    if(_viewedType == AmityViewedType.POST){
      _request.postId = _viewedId;
      }else{
      _request.storyId = _viewedId;
      }
    if (token != null) {
      _request.token = token;
    }
    _request.limit = limit;
    return _useCase.get(_request);
  }
}
