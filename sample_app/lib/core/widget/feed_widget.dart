import 'package:amity_sdk/domain/model/amity_file/amity_file.dart';
import 'package:amity_sdk/domain/model/amity_post.dart';
import 'package:amity_sdk/public/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_example/core/utils/extension/date_extension.dart';
import 'package:flutter_application_1_example/full_screen_video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedWidget extends StatelessWidget {
  final AmityPost amityPost;
  const FeedWidget({Key? key, required this.amityPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return ValueListenableBuilder<AmityPost>(
      valueListenable: amityPost,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                ),
              ]),
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    value.postedUser!.displayName!,
                    style: _themeData.textTheme.headline5,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      size: 18,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Created At - ' + value.createdAt!.format(),
                      style: _themeData.textTheme.caption,
                    ),
                    Text(
                      'Updated At - ' + value.updatedAt!.format(),
                      style: _themeData.textTheme.caption,
                    ),
                    if (value.target is UserTarget)
                      Text(
                        'Posted On : ' +
                            ((value.target as UserTarget)
                                    .targetUser
                                    ?.displayName ??
                                'No name'),
                        style: _themeData.textTheme.caption,
                      ),
                    if (value.target is CommunityTarget)
                      Text(
                        'Posted On : ' +
                            ((value.target as CommunityTarget)
                                    .targetCommunity
                                    ?.displayName ??
                                'No name') +
                            ' Community',
                        style: _themeData.textTheme.caption,
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeedContentWidget(amityPostData: value.data!),
                    const SizedBox(height: 8),
                    if (value.children != null)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...List.generate(value.children!.length, (index) {
                            final amityChildPost = value.children![index];
                            if (amityChildPost.data == null) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.red.shade400,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  'Media Type ${amityChildPost.type} not supported',
                                  style: _themeData.textTheme.bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              );
                            }
                            return FeedContentWidget(
                                amityPostData: amityChildPost.data!);
                          })
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     TextButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.thumb_up,
              //         color: Colors.grey,
              //       ),
              //       label: Text(
              //         'My : ${amityPost.myReactions}',
              //         style: _themeData.textTheme.bodyText1,
              //       ),
              //     ),
              //     TextButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.thumb_up,
              //         color: Colors.grey,
              //       ),
              //       label: Text(
              //         'Count : ${amityPost.reactionCount}',
              //         style: _themeData.textTheme.bodyText1,
              //       ),
              //     ),
              //     TextButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.comment,
              //         color: Colors.grey,
              //       ),
              //       label: Text(
              //         'Count : ${amityPost.commentCount}',
              //         style: _themeData.textTheme.bodyText1,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 8),
              // Row(
              //   children: [
              //     TextButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(Icons.flag_rounded, color: Colors.red),
              //       label: Text(
              //         'Count : ${amityPost.flagCount}',
              //         style: _themeData.textTheme.bodyText1,
              //       ),
              //     ),
              //     const SizedBox(width: 18),
              //     TextButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(Icons.flag_rounded, color: Colors.red),
              //       label: Text(
              //         'Flag by me : ${amityPost.isFlaggedByMe ?? false}',
              //         style: _themeData.textTheme.bodyText1,
              //       ),
              //     )
              //   ],
              // ),
              // const SizedBox(height: 12),
              Divider(height: .5, color: Colors.grey.shade300),
              Container(
                  key: UniqueKey(),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: FeedReactionInfoWidget(amityPost: value)),
              Divider(height: .5, color: Colors.grey.shade300),
              FeedActionWidget(key: UniqueKey(), amityPost: value),
            ],
          ),
        );
      },
    );
  }
}

class FeedContentWidget extends StatelessWidget {
  final AmityPostData amityPostData;
  const FeedContentWidget({Key? key, required this.amityPostData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);

    if (amityPostData is TextData) {
      final data = amityPostData as TextData;
      if (data.text != null && data.text!.isNotEmpty) {
        return Container(
          child: Text(
            data.text ?? '',
            style: _themeData.textTheme.subtitle1,
          ),
        );
      }
      return Container();
    }

    if (amityPostData is ImageData) {
      final data = amityPostData as ImageData;
      return Container(
        width: 100,
        height: 100,
        child: Image.network(
          data.image!.getUrl(AmityImageSize.MEDIUM),
          fit: BoxFit.cover,
        ),
      );
    }

    if (amityPostData is VideoData) {
      final data = amityPostData as VideoData;
      return Container(
        width: 100,
        height: 100,
        color: Colors.red,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                data.thumbnail!.getUrl(AmityImageSize.MEDIUM),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  data.getVideo(AmityVideoQuality.HIGH).then((value) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FullScreenVideoPlayer(
                          title: value.fileName,
                          url: value.fileUrl,
                        ),
                      ),
                    );
                  });
                },
                icon: const Icon(
                  Icons.play_circle_fill_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    }

    if (amityPostData is FileData) {
      final data = amityPostData as FileData;
      return TextButton.icon(
        onPressed: () {
          launch(data.fileInfo!.fileName);
        },
        icon: const Icon(Icons.attach_file_rounded, color: Colors.blue),
        label: Text(
          '${data.fileInfo?.fileName}',
          style: _themeData.textTheme.bodyText1!.copyWith(color: Colors.blue),
        ),
      );
    }

    return Container(
      color: Colors.red,
      child: Text('>>>>> ' + amityPostData.toString() + ' <<<<<<'),
    );
  }
}

class FeedReactionInfoWidget extends StatelessWidget {
  final AmityPost amityPost;
  const FeedReactionInfoWidget({Key? key, required this.amityPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'packages/amity_sdk/assets/ic_liked.png',
                height: 18,
                width: 18,
              ),
              label: Text(
                '${amityPost.reactionCount}',
                style: _themeData.textTheme.subtitle1!
                    .copyWith(color: Colors.black54),
              )),
          const Spacer(),
          Text(
            '0 Comment',
            style:
                _themeData.textTheme.subtitle1!.copyWith(color: Colors.black54),
          ),
          const SizedBox(width: 12),
          Text(
            '0 Flag',
            style:
                _themeData.textTheme.subtitle1!.copyWith(color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class FeedActionWidget extends StatelessWidget {
  final AmityPost amityPost;
  const FeedActionWidget({Key? key, required this.amityPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    bool _isFlagedByMe = amityPost.myReactions?.isNotEmpty ?? false;
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
              onPressed: () {
                if (_isFlagedByMe) {
                  amityPost.react().removeReaction('like');
                } else {
                  amityPost.react().addReaction('like');
                }
              },
              icon: Image.asset(
                _isFlagedByMe
                    ? 'packages/amity_sdk/assets/ic_liked.png'
                    : 'packages/amity_sdk/assets/ic_like.png',
                height: 18,
                width: 18,
              ),
              label: Text(
                'Like',
                style: _themeData.textTheme.subtitle1!.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              )),
          TextButton.icon(
              onPressed: () {},
              icon: const ImageIcon(
                  AssetImage('packages/amity_sdk/assets/ic_comment.png')),
              label: Text(
                'Comment',
                style: _themeData.textTheme.subtitle1!.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              )),
          TextButton.icon(
              onPressed: () {},
              icon: const ImageIcon(
                  AssetImage('packages/amity_sdk/assets/ic_flag.png')),
              // icon: Image.asset('packages/amity_sdk/assets/ic_comment.png'),
              label: Text(
                'Flag',
                style: _themeData.textTheme.subtitle1!.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
