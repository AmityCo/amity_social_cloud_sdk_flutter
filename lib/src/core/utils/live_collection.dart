import 'dart:async';

import 'package:amity_sdk/src/core/core.dart';

abstract class LiveCollection<Model> {
  String? currentToken = null;
  bool isFetching = false;
  bool _isFirstPage = true;

  //abstract functions
  Future<PageListData<List<Model>, String>> getNextPageRequest(String? token);

  Future<PageListData<List<Model>, String>> getFirstPageRequest();

  Stream<List<Model>> asStream();

  //open functions
  Future loadNext() async {
    if (!isFetching) {
      isFetching = true;
      if (_isFirstPage) {
        return await getFirstPageRequest().then((value) {
          currentToken = value.token;
          isFetching = false;
          _isFirstPage = false;
        });
      } else {
        return await getNextPageRequest(currentToken).then((value) {
          currentToken = value.token;
          isFetching = false;
          _isFirstPage = false;
        });
      }
    }
  }

  bool hasNextPage() {
    return currentToken != null;
  }
}
