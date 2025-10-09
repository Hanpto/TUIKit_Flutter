import 'package:atomic_x/base_component/base_component.dart';
import 'package:atomic_x_core/atomicxcore.dart';
import 'package:flutter/material.dart';

import '../message_list.dart';

class MessageItem extends StatelessWidget {
  final MessageInfo message;
  final String conversationID;
  final bool showAvatar;
  final bool isGroup;
  final double maxWidth;
  final MessageListStore? messageListStore;
  final bool isHighlighted;
  final VoidCallback? onHighlightComplete;
  final String alignment;
  final OnUserClick? onUserClick;

  const MessageItem({
    super.key,
    required this.message,
    required this.conversationID,
    this.showAvatar = true,
    this.isGroup = false,
    this.maxWidth = 200,
    this.messageListStore,
    required this.isHighlighted,
    this.onHighlightComplete,
    this.alignment = AppBuilder.MESSAGE_ALIGNMENT_TWO_SIDED,
    this.onUserClick,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelf = message.isSelf;

    Widget messageBubble = MessageBubble(
      message: message,
      conversationID: conversationID,
      isSelf: isSelf,
      maxWidth: maxWidth,
      messageListStore: messageListStore,
      isHighlighted: isHighlighted,
      onHighlightComplete: onHighlightComplete,
      alignment: alignment,
    );

    if (message.messageType == MessageType.system ||
        (message.messageType == MessageType.custom && _isSystemStyleCustomMessage(message))) {
      return messageBubble;
    }

    switch (alignment) {
      case AppBuilder.MESSAGE_ALIGNMENT_TWO_SIDED:
        return _buildTwoSidedLayout(messageBubble, isSelf);
      case AppBuilder.MESSAGE_ALIGNMENT_LEFT:
        return _buildLeftAlignedLayout(messageBubble, isSelf);
      case AppBuilder.MESSAGE_ALIGNMENT_RIGHT:
        return _buildRightAlignedLayout(messageBubble, isSelf);
      default:
        return _buildTwoSidedLayout(messageBubble, isSelf);
    }
  }

  bool _isSystemStyleCustomMessage(MessageInfo message) {
    try {
      final customMessage = message.messageBody?.customMessage?.data;
      final customInfo = ChatUtil.jsonData2Dictionary(customMessage);
      if (customInfo != null) {
        return customInfo['businessID'] == 'group_create';
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Widget _buildTwoSidedLayout(Widget messageBubble, bool isSelf) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isSelf ? _buildSelfMessage(messageBubble) : _buildOtherMessage(messageBubble),
      ),
    );
  }

  Widget _buildLeftAlignedLayout(Widget messageBubble, bool isSelf) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar)
            GestureDetector(
              onTap: () {
                if (!isSelf && onUserClick != null && message.sender != null) {
                  onUserClick!(message.sender!);
                }
              },
              child: Avatar(
                content: AvatarImageContent(url: message.rawMessage?.faceUrl, name: message.sender ?? ''),
              ),
            ),
          if (showAvatar) const SizedBox(width: 8),
          Flexible(
            child: messageBubble,
          ),
        ],
      ),
    );
  }

  Widget _buildRightAlignedLayout(Widget messageBubble, bool isSelf) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: messageBubble,
          ),
          if (showAvatar) const SizedBox(width: 8),
          if (showAvatar)
            GestureDetector(
              onTap: () {
                if (!isSelf && onUserClick != null && message.sender != null) {
                  onUserClick!(message.sender!);
                }
              },
              child: Avatar(
                content: AvatarImageContent(url: message.rawMessage?.faceUrl, name: message.sender ?? ''),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildSelfMessage(Widget messageBubble) {
    return [
      Flexible(
        child: messageBubble,
      ),
    ];
  }

  List<Widget> _buildOtherMessage(Widget messageBubble) {
    return [
      if (showAvatar)
        GestureDetector(
          onTap: () {
            if (onUserClick != null && message.sender != null) {
              onUserClick!(message.sender!);
            }
          },
          child: Avatar(
            content: AvatarImageContent(url: message.rawMessage?.faceUrl, name: message.sender ?? ''),
          ),
        ),
      if (showAvatar) const SizedBox(width: 8),
      Flexible(
        child: messageBubble,
      ),
    ];
  }
}
