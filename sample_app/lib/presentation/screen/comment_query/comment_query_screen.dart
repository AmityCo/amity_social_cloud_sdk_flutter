import 'package:amity_sdk/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_sample_app/core/constant/global_constant.dart';
import 'package:flutter_social_sample_app/core/widget/add_comment_widget.dart';
import 'package:flutter_social_sample_app/core/widget/comment_widget.dart';
import 'package:flutter_social_sample_app/core/widget/dialog/error_dialog.dart';

class CommentQueryScreen extends StatefulWidget {
  const CommentQueryScreen(this._postId, {Key? key}) : super(key: key);
  final String _postId;
  @override
  State<CommentQueryScreen> createState() => _CommentQueryScreenState();
}

class _CommentQueryScreenState extends State<CommentQueryScreen> {
  late PagingController<AmityComment> _controller;
  final amityComments = <AmityComment>[];

  final scrollcontroller = ScrollController();
  bool loading = false;

  AmityComment? _replyToComment;

  @override
  void initState() {
    _controller = PagingController(
      pageFuture: (token) => AmitySocialClient.newCommentRepository()
          .getComments()
          .post(widget._postId)
          .getPagingData(token: token, limit: GlobalConstant.pageSize),
      pageSize: GlobalConstant.pageSize,
    )..addListener(
        () {
          if (_controller.error == null) {
            setState(() {
              amityComments.clear();
              amityComments.addAll(_controller.loadedItems);
            });
          } else {
            //Error on pagination controller
            setState(() {});
            ErrorDialog.show(context,
                title: 'Error', message: _controller.error.toString());
          }
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
      appBar: AppBar(title: const Text('Comment Feed')),
      body: Column(
        children: [
          Expanded(
            child: amityComments.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      _controller.reset();
                      _controller.fetchNextPage();
                    },
                    child: ListView.builder(
                      controller: scrollcontroller,
                      itemCount: amityComments.length,
                      itemBuilder: (context, index) {
                        final amityComment = amityComments[index];
                        return Container(
                            child: CommentWidget(amityComment, (value) {
                          setState(() {
                            _replyToComment = value;
                          });
                        }));
                        // return FeedWidget(amityPost: amityPost);
                      },
                      // separatorBuilder: (context, index) => Container(
                      //     margin: const EdgeInsets.symmetric(horizontal: 36),
                      //     child:
                      //         Divider(height: 1, color: Colors.grey.shade400)),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: _controller.isFetching
                        ? const CircularProgressIndicator()
                        : const Text('No Post'),
                  ),
          ),
          if (_controller.isFetching && amityComments.isNotEmpty)
            Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
          if (_replyToComment != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Row(
                children: [
                  const Text('Reply to '),
                  Text('@${_replyToComment!.user!.userId}'),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _replyToComment = null;
                      });
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                    ),
                  )
                ],
              ),
            ),
          Container(
            margin: const EdgeInsets.all(12),
            child: AddCommentWidget(
              AmityCoreClient.getCurrentUser(),
              (text) {
                if (_replyToComment != null) {
                  ///Add comment to [_replyToComment] comment
                  // _replyToComment!.comment().create().text(text).send();
                  AmitySocialClient.newCommentRepository()
                      .createComment()
                      .post(widget._postId)
                      .parentId(_replyToComment!.commentId!)
                      .create()
                      .text(text)
                      .send();

                  return;
                }

                AmitySocialClient.newCommentRepository()
                    .createComment()
                    .post(widget._postId)
                    .create()
                    .text(text)
                    .send();
                return;
              },
            ),
          ),
        ],
      ),
    );
  }
}
