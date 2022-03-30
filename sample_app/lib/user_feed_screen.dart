import 'package:amity_sdk/core/utils/paging_controller.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_example/feed_widget.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  late PagingController<AmityPost> _controller;
  final amityPosts = <AmityPost>[];

  final scrollcontroller = ScrollController();
  bool loading = false;
  @override
  void initState() {
    _controller = PagingController(
      pageFuture: (token) => AmitySocialClient.newFeedRepository()
          .getUserFeed(widget.userId)
          .getPagingData(token: token, limit: 10),
      pageSize: 10,
    )..addListener(
        () {
          setState(() {
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
      appBar: AppBar(title: Text('User Feed - ${widget.userId}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollcontroller,
              itemCount: amityPosts.length,
              itemBuilder: (context, index) {
                final amityPost = amityPosts[index];
                return FeedWidget(amityPost: amityPost);
              },
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
