import 'package:amity_sdk/core/utils/paging_controller.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_sample_app/core/widget/feed_widget.dart';
import 'package:flutter_social_sample_app/core/constant/global_constant.dart';

class CommunityFeedScreen extends StatefulWidget {
  const CommunityFeedScreen({Key? key, required this.communityId})
      : super(key: key);
  final String communityId;
  @override
  State<CommunityFeedScreen> createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> {
  late PagingController<AmityPost> _controller;
  final amityPosts = <AmityPost>[];

  final scrollcontroller = ScrollController();
  bool loading = false;
  @override
  void initState() {
    _controller = PagingController(
      pageFuture: (token) => AmitySocialClient.newFeedRepository()
          .getCommunityFeed(widget.communityId)
          .getPagingData(token: token, limit: GlobalConstant.pageSize),
      pageSize: GlobalConstant.pageSize,
    )..addListener(
        () {
          setState(() {
            amityPosts.clear();
            amityPosts.addAll(_controller.loadedItems);
          });

          print(_controller.loadedItems.toString());
        },
      );

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.fetchNextPage();
    });

    scrollcontroller.addListener(pagination);

    super.initState();
  }

  void pagination() {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        _controller.hasMoreItems) {
      setState(() {
        _controller.fetchNextPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Feed - ${widget.communityId}')),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _controller.reset();
                _controller.fetchNextPage();
              },
              child: ListView.builder(
                controller: scrollcontroller,
                itemCount: amityPosts.length,
                itemBuilder: (context, index) {
                  final amityPost = amityPosts[index];
                  return FeedWidget(amityPost: amityPost);
                },
              ),
            ),
          ),
          if (_controller.isFetching)
            Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
