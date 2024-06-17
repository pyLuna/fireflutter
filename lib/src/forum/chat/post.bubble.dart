import 'package:cached_network_image/cached_network_image.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class PostBubble extends StatelessWidget {
  const PostBubble({
    super.key,
    required this.post,
  });

  final Post post;
  bool get isMine => post.uid == myUid;

  bool get isLongText =>
      (post.content.length > 100 || '\n'.allMatches(post.content).length > 5);

  String get text {
    dog('isLongText: $isLongText');
    dog('post.content: ${post.content}');
    if (isLongText) {
      String t = post.content;
      final splits = t.split('\n');
      if (splits.length > 5) {
        return '${splits.sublist(0, 5).join('\n')}...';
      } else {
        return '${post.content.substring(0, 99)}...';
      }
    } else {
      return post.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    dog("Text: $text");
    if (post.deleted) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMine) ...[
                UserAvatar(
                  uid: post.uid,
                  cacheId: post.uid,
                  size: 32,
                  radius: 13,
                ),
              ],
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment:
                    isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  dateAndName(context: context, post: post),
                  const SizedBox(height: 4),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => ForumService.instance.showPostViewScreen(
                      context: context,
                      post: post,
                      commentable: false,
                    ),
                    child: Column(
                      crossAxisAlignment: isMine
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .7,
                          ),
                          decoration: BoxDecoration(
                            color: isMine
                                ? Colors.amber.shade200
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(isMine ? 16 : 0),
                              topRight: Radius.circular(isMine ? 0 : 16),
                              bottomLeft: const Radius.circular(16),
                              bottomRight: const Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (post.urls.isNotEmpty)
                                SizedBox(
                                  height: 180,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: post.urls.first,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      dog('post.bubble: Image url has problem: $error');
                                      return const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      );
                                    },
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Text(
                                  text.orBlocked(
                                    post.uid,
                                    T.blockedContentMessage.tr,
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Text(
                        //   '   ${isMine ? '수정 삭제' : ''}  ',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .labelSmall!
                        //       .copyWith(color: Colors.grey.shade600),
                        // ),
                        if (isLongText)
                          Text(
                            "${T.readMore.tr}...",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.grey.shade600),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (!isMine) const Spacer(),
        ],
      ),
    );
  }

  dateAndName({required BuildContext context, required Post post}) {
    return Row(
      crossAxisAlignment:
          isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.2,
          ),
          child: UserDisplayName(
            uid: post.uid,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 11,
                ),
          ),
        ),
        const SizedBox(width: 8),
        DateTimeShort(
          dateTime: post.createdAt,
        ),
      ],
    );
  }
}
