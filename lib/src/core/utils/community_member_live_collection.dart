import 'dart:async';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:amity_sdk/src/core/core.dart';
import 'package:amity_sdk/src/core/utils/amity_nonce.dart';
import 'package:amity_sdk/src/data/data_source/data_source.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_fetch_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_observe_new_item_usecase.dart';
import 'package:amity_sdk/src/domain/usecase/community/member/community_member_observe_usecase.dart';

class CommunityMemberLiveCollection extends LiveCollection<AmityCommunityMember> {
  RequestBuilder<GetCommunityMembersRequest> request;

  CommunityMemberLiveCollection({required this.request});

  @override
  AmityNonce getNonce() {
    return request().getNonce();
  }

  @override
  int getHash() {
    return request().getHashCode();
  }

  @override
  Future<PageListData<List<AmityCommunityMember>, String>> getFirstPageRequest() async {
    final params = request();
    params.options?.token = null;
    params.options?.limit = defaultPageSize;
    return await serviceLocator<CommunityMemberFetchListUseCase>().get(params);
  }

  @override
  Future<PageListData<List<AmityCommunityMember>, String>> getNextPageRequestInternal(
      String? token) async {
    final params = request();
    params.options?.token = token;
    params.options?.limit = null;
    return await serviceLocator<CommunityMemberFetchListUseCase>().get(params);
  }

  @override
  StreamController<List<AmityCommunityMember>> getStreamController() {
    return serviceLocator<CommunityMemberObserveUsecase>().listen(request);
  }

  @override
  StreamController<PagingIdHiveEntity> observeNewItem() {
    return serviceLocator<CommunityMemberObserveNewItemUsecase>().listen(request);
  }
}