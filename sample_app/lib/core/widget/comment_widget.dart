import 'dart:async';

import 'package:amity_sdk/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_sample_app/core/utils/extension/date_extension.dart';
import 'package:flutter_social_sample_app/core/widget/dialog/edit_comment_dialog.dart';
import 'package:flutter_social_sample_app/core/widget/feed_widget.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget(this.amityComment, this.onReply, {Key? key})
      : super(key: key);
  final AmityComment amityComment;
  final ArgumentCallback<AmityComment> onReply;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late String text;

  bool _viewMoreReply = false;
  late Timer periodicTimer;
  @override
  void initState() {
    super.initState();

    periodicTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);

    return ValueListenableBuilder<AmityComment>(
      valueListenable: widget.amityComment,
      builder: (context, value, child) => !(value.isDeleted ?? false)
          ? _getBody(context, value)
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.info_rounded),
                  const SizedBox(width: 12),
                  Text(
                    'Comment has been deleted',
                    style: _themeData.textTheme.caption,
                  )
                ],
              ),
            ),
    );
  }

  Widget _getBody(BuildContext context, AmityComment value) {
    final _themeData = Theme.of(context);
    AmityUser _user = value.user!;

    AmityCommentData data = value.data!;
    if (data is CommentTextData) text = data.text!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.withOpacity(.3)),
            child: _user.avatarUrl != null
                ? Image.network(
                    _user.avatarUrl!,
                    fit: BoxFit.fill,
                  )
                : Image.asset('packages/amity_sdk/assets/user_placeholder.png'),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _user.displayName!,
                        style: _themeData.textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 6)),
                      TextSpan(
                        text: text,
                        style: _themeData.textTheme.bodyText2!.copyWith(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      value.createdAt!.beforeTime(),
                      style: _themeData.textTheme.caption!.copyWith(),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                        onTap: () {
                          widget.onReply(value);
                        },
                        child: Text(
                          'Reply',
                          style: _themeData.textTheme.caption!.copyWith(),
                        ))
                  ],
                ),
                const SizedBox(height: 6),
                if (value.childrenNumber! > 0)
                  Container(
                    // color: Colors.red,
                    margin: const EdgeInsets.only(left: 12),
                    child: !_viewMoreReply
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                _viewMoreReply = !_viewMoreReply;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 6),
                              child: Text(
                                '~~~~~~ View ${value.childrenNumber} more reply',
                                style: _themeData.textTheme.caption!.copyWith(),
                              ),
                            ),
                          )
                        : _getChildCommentWidget(context, value.latestReplies!),
                  )
              ],
            ),
          ),
          if (_user.userId == AmityCoreClient.getUserId())
            PopupMenuButton(
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    child: Text("Edit"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Delete (Soft)"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: Text("Delete (Hard)"),
                    value: 3,
                    enabled: false,
                  )
                ];
              },
              child: const Icon(
                Icons.more_vert_rounded,
                size: 18,
              ),
              onSelected: (index1) {
                if (index1 == 1) {
                  EditCommentDialog.show(context, amityComment: value);
                }
                if (index1 == 2) {
                  value.delete();
                }
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    periodicTimer.cancel();
    super.dispose();
  }

  Widget _getChildCommentWidget(
      BuildContext context, List<AmityComment> comments) {
    final _themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        comments.length,
        (index) {
          AmityUser _user = comments[index].user!;

          AmityCommentData data = comments[index].data!;
          if (data is CommentTextData) text = data.text!;
          return !(comments[index].isDeleted ?? false)
              ? Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(.3)),
                        child: _user.avatarUrl != null
                            ? Image.network(
                                _user.avatarUrl!,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                'packages/amity_sdk/assets/user_placeholder.png'),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: _user.displayName!,
                                    style: _themeData.textTheme.bodyText1!
                                        .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const WidgetSpan(child: SizedBox(width: 6)),
                                  TextSpan(
                                    text: text,
                                    style: _themeData.textTheme.bodyText2!
                                        .copyWith(),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  comments[index].createdAt!.beforeTime(),
                                  style:
                                      _themeData.textTheme.caption!.copyWith(),
                                ),
                                const SizedBox(width: 12),
                                // InkWell(
                                //   onTap: () {
                                //     widget.onReply(value);
                                //   },
                                //   child: Text(
                                //     'Reply',
                                //     style: _themeData.textTheme.caption!.copyWith(),
                                //   ),
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (_user.userId == AmityCoreClient.getUserId())
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text("Delete (Soft)"),
                                value: 2,
                              ),
                              PopupMenuItem(
                                child: Text("Delete (Hard)"),
                                value: 3,
                                enabled: false,
                              )
                            ];
                          },
                          child: const Icon(
                            Icons.more_vert_rounded,
                            size: 18,
                          ),
                          onSelected: (index1) {
                            if (index1 == 1) {
                              EditCommentDialog.show(context,
                                  amityComment: comments[index]);
                            }
                            if (index1 == 2) {
                              comments[index].delete();
                            }
                          },
                        ),
                    ],
                  ),
                )
              : Container();
        },
      )..add(Container(
          padding: const EdgeInsets.only(left: 12, top: 8),
          child: InkWell(
            onTap: () {
              setState(() {
                _viewMoreReply = !_viewMoreReply;
              });
            },
            child: Text(
              'View less',
              style: _themeData.textTheme.caption!.copyWith(),
            ),
          ),
        )),
    );
  }
}
