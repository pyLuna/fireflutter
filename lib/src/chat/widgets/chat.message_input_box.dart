import 'package:cached_network_image/cached_network_image.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

/// 채팅 메시지 입력 박스
///
/// TODO - 업로드 progress bar 를 이 위젯에 직접 표시 할 것.
class ChatMessageInputBox extends StatefulWidget {
  const ChatMessageInputBox({
    super.key,
    required this.chat,
    this.cameraIcon,
    this.sendIcon,
    this.onProgress,
    this.onSend,
  });

  final ChatModel chat;

  /// TODO - 이 것은 chat customize 로 들어가야 하나?
  final Widget? cameraIcon;
  final Widget? sendIcon;

  final Function(double?)? onProgress;

  /// [double] is null when upload is completed.
  final void Function({String? text, String? url})? onSend;

  @override
  State<ChatMessageInputBox> createState() => _ChatMessageInputBoxState();
}

class _ChatMessageInputBoxState extends State<ChatMessageInputBox> {
  final inputController = TextEditingController();
  double? progress;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chat.room.isSingleChat &&
        iHave.blocked(widget.chat.room.otherUserUid!)) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<ChatMessage?>(
          valueListenable: widget.chat.replyTo,
          builder: (context, replyTo, _) {
            if (replyTo == null) {
              return const SizedBox.shrink();
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.reply),
                                const SizedBox(width: 4),
                                UserDisplayName(
                                  uid: replyTo.uid!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            if (replyTo.text != null)
                              Text(
                                '${replyTo.text}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (replyTo.url != null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6,
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: replyTo.url!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                      // if thumbnail is not available, show original image
                                      errorWidget: (context, url, error) {
                                        return const Icon(Icons.error_outline,
                                            color: Colors.red);
                                      },
                                      errorListener: (value) => dog(
                                          'chat.message_input_box: Image load error: $value'),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.chat.replyTo.value = null;
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            );
          },
        ),
        if (progress != null && !progress!.isNaN)
          LinearProgressIndicator(value: progress),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: inputController,
            decoration: InputDecoration(
              isDense: false,
              contentPadding: const EdgeInsets.only(top: 7),
              fillColor: Colors.transparent,
              focusColor: Colors.transparent,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: T.pleaseEnterMessage.tr,
              hintStyle: Theme.of(context).textTheme.labelLarge,
              hintMaxLines: 1,
              prefixIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(top: 10),
                    visualDensity: VisualDensity.compact,
                    icon: widget.cameraIcon ?? const Icon(Icons.camera_alt),
                    onPressed: () async {
                      /// 인증된 사용자만 파일 전송 옵션
                      if (widget.chat.room.uploadVerifiedUserOnly &&
                          iam.notVerified) {
                        return error(
                          context: context,
                          message: T.notVerifiedMessage.tr,
                        );
                      }
                      final url = await StorageService.instance.upload(
                        context: context,
                        // Review
                        camera: true,
                        gallery: true,
                        progress: (p) => widget.onProgress?.call(p) ?? mounted
                            ? setState(() => progress = p)
                            : null,
                        complete: () => widget.onProgress?.call(null) ?? mounted
                            ? setState(() => progress = null)
                            : null,
                      );

                      await send(url: url);
                      widget.onSend?.call(text: null, url: url);
                    },
                  ),
                  ChatService
                          .instance.customize.messageInputBoxPrefixIconBuilder
                          ?.call(widget.chat) ??
                      const SizedBox.shrink(),
                ],
              ),
              suffixIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(top: 10),
                    visualDensity: VisualDensity.compact,
                    icon: widget.sendIcon ?? const Icon(Icons.send),
                    onPressed: () async {
                      String text = inputController.text.trim();
                      if (text.isEmpty) return;

                      /// 인증된 사용자만 URL 전송 옵션
                      if (text.hasUrl == true &&
                          widget.chat.room.urlVerifiedUserOnly &&
                          iam.notVerified) {
                        return error(
                          context: context,
                          message: T.notVerifiedMessage.tr,
                        );
                      }

                      inputController.clear();
                      await send(text: text);
                      widget.onSend?.call(text: text, url: null);
                    },
                  ),
                ],
              ),
            ),
            minLines: 1,
            maxLines: 5,
          ),
        ),
      ],
    );
  }

  send({String? text, String? url}) async {
    if (text != null) {
      await widget.chat.sendMessage(
        text: text,
        replyTo: widget.chat.replyTo.value,
      );
    }
    if (url != null) {
      await widget.chat.sendMessage(
        url: url,
        replyTo: widget.chat.replyTo.value,
      );
    }
    widget.chat.replyTo.value = null;
  }
}
