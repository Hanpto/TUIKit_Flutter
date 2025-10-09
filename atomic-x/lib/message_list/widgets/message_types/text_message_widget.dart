import 'package:atomic_x/base_component/base_component.dart';
import 'package:atomic_x_core/atomicxcore.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';

import '../../../message_input/src/chat_special_text_span_builder.dart';
import '../message_status_mixin.dart';

typedef BackgroundBuilder = Widget Function(Widget child);

class TextMessageWidget extends StatefulWidget {
  final MessageInfo message;
  final bool isSelf;
  final double maxWidth;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<String>? onLinkTapped;
  final GlobalKey? bubbleKey;
  final BackgroundBuilder? backgroundBuilder;
  final String alignment;
  final VoidCallback? onResendTap;

  const TextMessageWidget({
    super.key,
    required this.message,
    required this.isSelf,
    required this.maxWidth,
    this.onTap,
    this.onLongPress,
    this.onLinkTapped,
    this.bubbleKey,
    this.backgroundBuilder,
    this.alignment = AppBuilder.MESSAGE_ALIGNMENT_TWO_SIDED,
    this.onResendTap,
  });

  @override
  State<TextMessageWidget> createState() => _TextMessageWidgetState();
}

class _TextMessageWidgetState extends State<TextMessageWidget> with MessageStatusMixin {
  @override
  Widget build(BuildContext context) {
    final colors = BaseThemeProvider.colorsOf(context);

    final content = Container(
      key: widget.bubbleKey,
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth * 0.7,
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: _buildTextWithStatusAndTime(colors),
    );

    final bubble = widget.backgroundBuilder?.call(content) ??
        Container(
          decoration: BoxDecoration(
            color: _getBubbleColor(colors),
            borderRadius: _getBubbleBorderRadius(),
          ),
          child: content,
        );

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: bubble,
    );
  }

  Widget _buildTextWithStatusAndTime(SemanticColorScheme colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: _buildTextContent(colors),
        ),
        ...[
          const SizedBox(width: 8),
          ...buildStatusAndTimeWidgets(
            message: widget.message,
            isSelf: widget.isSelf,
            colors: colors,
            onResendTap: widget.onResendTap,
          ),
        ],
      ],
    );
  }

  Widget _buildTextContent(SemanticColorScheme colorsTheme) {
    final text = widget.message.messageBody?.text ?? '';

    return ExtendedText(
      _getContentSpan(text, colorsTheme),
      onSpecialTextTap: (dynamic parameter) {
        if (parameter.toString().startsWith('\$')) {
          widget.onLinkTapped?.call((parameter.toString()).replaceAll('\$', ''));
        }
      },
      specialTextSpanBuilder: ChatSpecialTextSpanBuilder(
        colorScheme: colorsTheme,
        onTapUrl: widget.onLinkTapped ?? (_) {},
        showAtBackground: true,
      ),
      style: TextStyle(
        color: widget.isSelf ? colorsTheme.textColorAntiPrimary : colorsTheme.textColorPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    );
  }

  String _getContentSpan(String text, SemanticColorScheme colors) {
    String contentData = "";
    Iterable<RegExpMatch> matches = ChatUtils.urlReg.allMatches(text);

    int index = 0;
    for (RegExpMatch match in matches) {
      String c = text.substring(match.start, match.end);
      if (match.start == index) {
        index = match.end;
      }
      if (index < match.start) {
        String a = text.substring(index, match.start);
        index = match.end;
        contentData += a;
      }

      if (ChatUtils.urlReg.hasMatch(c)) {
        contentData += '${HttpText.flag}$c${HttpText.flag}';
      } else {
        contentData += c;
      }
    }

    if (index < text.length) {
      String a = text.substring(index, text.length);
      contentData += a;
    }

    return contentData.isNotEmpty ? contentData : text;
  }

  Color _getBubbleColor(SemanticColorScheme colorsTheme) {
    if (widget.isSelf) {
      return colorsTheme.bgColorBubbleOwn;
    } else {
      return colorsTheme.bgColorBubbleReciprocal;
    }
  }

  BorderRadius _getBubbleBorderRadius() {
    switch (widget.alignment) {
      case 'left':
        return const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(18),
        );
      case 'right':
        return const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(0),
        );
      case 'two-sided':
      default:
        if (widget.isSelf) {
          return const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(0),
          );
        } else {
          return const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(18),
          );
        }
    }
  }
}
